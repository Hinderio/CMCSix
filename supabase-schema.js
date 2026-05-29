window.BEDLINK_SUPABASE_SQL_NOTE = `Das vollständige produktive SQL Statement liegt in supabase.sql.

Setup:
1. Supabase SQL Editor öffnen.
2. supabase.sql komplett einfügen und ausführen.
3. Email Auth aktivieren.
4. Site URL und Redirect URL auf https://hinderio.github.io/CMCSix/ setzen.

Tabellen:
- hospitals
- hospital_beds
- bed_reservations
- bed_activity_log

RPC:
- reserve_bed_for_request(p_request_id uuid, p_bed_id uuid)
`;
