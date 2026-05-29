-- BedLink Spitalbettenvermittlung - Supabase Schema + Seed
-- Version 1.0.1

create extension if not exists pgcrypto;

create or replace function public.set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create table if not exists public.hospitals (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name text not null,
  short_name text not null,
  city text not null,
  canton text,
  region text not null default 'Schweiz',
  capacity_total integer not null check (capacity_total >= 0),
  sort_order integer not null default 100,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.hospital_beds (
  id uuid primary key default gen_random_uuid(),
  hospital_id uuid not null references public.hospitals(id) on delete restrict,
  bed_code text not null,
  ward text,
  room text,
  department text not null check (department in ('Innere Medizin','Chirurgie','Intensivpflege','Telemetrie')),
  care_level text not null default 'standard' check (care_level in ('standard','monitoring','intermediate','intensive')),
  status text not null default 'available' check (status in ('available','reserved','occupied','cleaning','blocked','discharge_pending')),
  features jsonb not null default '{}'::jsonb,
  patient_reference text,
  reserved_until timestamptz,
  notes text,
  last_status_change_at timestamptz not null default now(),
  is_archived boolean not null default false,
  created_by uuid default auth.uid() references auth.users(id) on delete set null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint hospital_beds_unique_code_per_hospital unique (hospital_id, bed_code)
);

create table if not exists public.bed_reservations (
  id uuid primary key default gen_random_uuid(),
  hospital_id uuid references public.hospitals(id) on delete restrict,
  bed_id uuid references public.hospital_beds(id) on delete set null,
  requester_name text not null,
  requester_contact text,
  patient_reference text,
  department text not null check (department in ('Innere Medizin','Chirurgie','Intensivpflege','Telemetrie')),
  priority text not null default 'normal' check (priority in ('low','normal','urgent','emergency')),
  requested_features jsonb not null default '{}'::jsonb,
  status text not null default 'open' check (status in ('open','matched','reserved','admitted','cancelled','completed','expired')),
  starts_at timestamptz not null default now(),
  ends_at timestamptz,
  response_minutes integer,
  decision_at timestamptz,
  notes text,
  created_by uuid default auth.uid() references auth.users(id) on delete set null,
  updated_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint bed_reservations_time_check check (ends_at is null or ends_at >= starts_at)
);

create table if not exists public.bed_activity_log (
  id uuid primary key default gen_random_uuid(),
  hospital_id uuid references public.hospitals(id) on delete set null,
  bed_id uuid references public.hospital_beds(id) on delete set null,
  reservation_id uuid references public.bed_reservations(id) on delete set null,
  action text not null,
  payload jsonb not null default '{}'::jsonb,
  created_by uuid default auth.uid() references auth.users(id) on delete set null,
  created_at timestamptz not null default now()
);

create index if not exists hospitals_active_sort_idx on public.hospitals(is_active, sort_order);
create index if not exists hospital_beds_status_idx on public.hospital_beds(status, department) where is_archived = false;
create index if not exists hospital_beds_hospital_idx on public.hospital_beds(hospital_id) where is_archived = false;
create index if not exists hospital_beds_features_gin_idx on public.hospital_beds using gin (features);
create index if not exists bed_reservations_status_idx on public.bed_reservations(status, priority, starts_at);
create index if not exists bed_activity_log_created_idx on public.bed_activity_log(created_at desc);

drop trigger if exists hospitals_updated_at on public.hospitals;
create trigger hospitals_updated_at before update on public.hospitals for each row execute function public.set_updated_at();
drop trigger if exists hospital_beds_updated_at on public.hospital_beds;
create trigger hospital_beds_updated_at before update on public.hospital_beds for each row execute function public.set_updated_at();
drop trigger if exists bed_reservations_updated_at on public.bed_reservations;
create trigger bed_reservations_updated_at before update on public.bed_reservations for each row execute function public.set_updated_at();

alter table public.hospitals enable row level security;
alter table public.hospital_beds enable row level security;
alter table public.bed_reservations enable row level security;
alter table public.bed_activity_log enable row level security;

drop policy if exists hospitals_authenticated on public.hospitals;
drop policy if exists beds_authenticated on public.hospital_beds;
drop policy if exists reservations_authenticated on public.bed_reservations;
drop policy if exists activity_authenticated on public.bed_activity_log;
create policy hospitals_authenticated on public.hospitals for all to authenticated using (true) with check (true);
create policy beds_authenticated on public.hospital_beds for all to authenticated using (true) with check (true);
create policy reservations_authenticated on public.bed_reservations for all to authenticated using (true) with check (true);
create policy activity_authenticated on public.bed_activity_log for all to authenticated using (true) with check (true);

create or replace function public.reserve_bed_for_request(p_request_id uuid, p_bed_id uuid)
returns table(reservation jsonb, bed jsonb)
language plpgsql
security invoker
as $$
declare
  v_req public.bed_reservations%rowtype;
  v_bed public.hospital_beds%rowtype;
  v_minutes integer;
begin
  select * into v_req from public.bed_reservations where id = p_request_id for update;
  if not found then raise exception 'Reservation request not found'; end if;
  if v_req.status not in ('open','matched') then raise exception 'Reservation request is no longer open'; end if;

  select * into v_bed from public.hospital_beds where id = p_bed_id and is_archived = false for update;
  if not found then raise exception 'Bed not found'; end if;
  if v_bed.status <> 'available' then raise exception 'Bed is not available'; end if;
  if v_bed.department <> v_req.department then raise exception 'Department mismatch'; end if;

  v_minutes := greatest(0, floor(extract(epoch from (now() - v_req.created_at)) / 60)::integer);

  update public.hospital_beds set status = 'reserved', patient_reference = v_req.patient_reference, reserved_until = v_req.ends_at, updated_by = auth.uid() where id = p_bed_id returning * into v_bed;
  update public.bed_reservations set bed_id = p_bed_id, hospital_id = v_bed.hospital_id, status = 'reserved', decision_at = now(), response_minutes = v_minutes, updated_by = auth.uid() where id = p_request_id returning * into v_req;
  insert into public.bed_activity_log (hospital_id, bed_id, reservation_id, action, payload, created_by) values (v_bed.hospital_id, v_bed.id, v_req.id, 'reservation_confirmed', jsonb_build_object('bed_code', v_bed.bed_code, 'response_minutes', v_minutes), auth.uid());
  return query select to_jsonb(v_req), to_jsonb(v_bed);
end;
$$;

grant execute on function public.reserve_bed_for_request(uuid, uuid) to authenticated;

insert into public.hospitals (slug, name, short_name, city, canton, region, capacity_total, sort_order) values
('luzern','Luzerner Kantonsspital Luzern','Luzern','Luzern','LU','Zentralschweiz',880,10),
('wolhusen','Luzerner Kantonsspital Wolhusen','Wolhusen','Wolhusen','LU','Zentralschweiz',880,20),
('sursee','Luzerner Kantonsspital Sursee','Sursee','Sursee','LU','Zentralschweiz',880,30),
('stans','Kantonsspital Nidwalden','Stans','Stans','NW','Zentralschweiz',880,40),
('sarnen','Kantonsspital Obwalden','Sarnen','Sarnen','OW','Zentralschweiz',66,50),
('uri','Kantonsspital Uri','Uri','Altdorf','UR','Zentralschweiz',80,60),
('zug','Zuger Kantonsspital','Zug','Baar','ZG','Zentralschweiz',180,70),
('aarau','Kantonsspital Aarau','Aarau','Aarau','AG','Nordwestschweiz',220,80),
('basel','Universitätsspital Basel','Basel','Basel','BS','Nordwestschweiz',775,90),
('bern','Inselspital Bern','Bern','Bern','BE','Mittelland',885,100),
('zuerich','Universitätsspital Zürich','Zürich','Zürich','ZH','Zürich',900,110),
('muri','Spital Muri','Muri','Muri','AG','Aargau',100,120),
('zofingen','Spital Zofingen','Zofingen','Zofingen','AG','Aargau',96,130),
('winti','Kantonsspital Winterthur','Winti','Winterthur','ZH','Zürich',500,140)
on conflict (slug) do update set name=excluded.name, short_name=excluded.short_name, city=excluded.city, canton=excluded.canton, region=excluded.region, capacity_total=excluded.capacity_total, sort_order=excluded.sort_order, is_active=true;

with d(sort_key, department, prefix, care_level, features) as (
  values
  (1,'Innere Medizin','IM','standard','{"oxygen":true,"telemetry":false,"isolation":false,"ventilator":false,"single_room":false,"bariatric":false}'::jsonb),
  (2,'Chirurgie','CH','standard','{"oxygen":true,"telemetry":false,"isolation":false,"ventilator":false,"single_room":true,"bariatric":false}'::jsonb),
  (3,'Intensivpflege','IP','intensive','{"oxygen":true,"telemetry":true,"isolation":true,"ventilator":true,"single_room":true,"bariatric":false}'::jsonb),
  (4,'Telemetrie','TM','monitoring','{"oxygen":true,"telemetry":true,"isolation":false,"ventilator":false,"single_room":false,"bariatric":false}'::jsonb)
)
insert into public.hospital_beds (hospital_id, bed_code, ward, room, department, care_level, status, features, notes)
select h.id, upper(left(h.slug,3)) || '-' || d.prefix || '-001', 'Station ' || d.prefix, lpad((h.sort_order+d.sort_key)::text,3,'0'), d.department, d.care_level,
case when d.department='Intensivpflege' and h.sort_order % 3 = 0 then 'occupied' when d.department='Telemetrie' and h.sort_order % 4 = 0 then 'reserved' else 'available' end,
d.features, 'SQL-Seed / produktiv anpassbar'
from public.hospitals h cross join d
on conflict (hospital_id, bed_code) do update set ward=excluded.ward, room=excluded.room, department=excluded.department, care_level=excluded.care_level, features=excluded.features, is_archived=false;

insert into public.bed_activity_log (action, payload) values ('seed_applied', jsonb_build_object('app','BedLink','version','1.0.1','hospitals',14));
