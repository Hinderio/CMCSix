# BedLink – Spitalbettenvermittlung

BedLink ist eine statische Enterprise-PWA für Spitalbetten, Statusverwaltung und Reservierungen mit Supabase. Die App orientiert sich visuell an der gelieferten Referenz: ruhige Premium-Oberfläche, klare KPI-Leiste, Spital-/Bettlisten, Filter, Match-Engine und mobile-first Layout.

## Enthalten

- `index.html`, `style.css`, `app.js`: vollständige PWA ohne Build-Schritt
- `supabase-config.js`: Supabase URL/Anon Key aus dem bereitgestellten Habits-ZIP übernommen
- `supabase.sql`: Tabellen, RLS-Policies, Indizes, Audit Log, RPC gegen Doppelreservationen und Seed-Daten
- `supabase-schema.js`: SQL-Vorschau in der App
- `manifest.json`, `service-worker.js`, Icons: GitHub-Pages- und PWA-tauglich

## Datensatz

Der Auftrag nennt „Anzahl Spitäler: 11“, listet aber 14 Standorte. Im ZIP sind bewusst alle 14 genannten Standorte enthalten:

Luzern, Wolhusen, Sursee, Stans, Sarnen, Uri, Zug, Aarau, Basel, Bern, Zürich, Muri, Zofingen, Winti.

Fachbereiche: Innere Medizin, Chirurgie, Intensivpflege, Telemetrie.

Für Luzern, Wolhusen, Sursee und Stans ist die gelieferte Kapazitätsangabe `880` je Standort übernommen, da der Auftrag diese Standorte gemeinsam mit `: 880` nennt. Die Werte können in `supabase.sql` oder direkt in der App/Datenbank angepasst werden.

## Lokal ansehen

```bash
cd BedLink-Spitalbettenvermittlung
python3 -m http.server 8080
```

Dann öffnen:

```text
http://localhost:8080
```

Ohne Login läuft die App sofort im lokalen Demo-Modus. Nach Supabase-Login ist Supabase die Quelle der Wahrheit; lokale Daten dienen nur als Cache/Demo.

## Supabase einrichten

1. Supabase-Projekt öffnen.
2. In **SQL Editor** die Datei `supabase.sql` vollständig ausführen.
3. In **Authentication → Providers** Email/Password aktivieren.
4. Einen internen User erstellen oder einladen.
5. In **Authentication → URL Configuration** die lokalen und produktiven URLs erlauben, z. B.:
   - `http://localhost:8080`
   - `https://<dein-github-user>.github.io/<repo-name>/`
6. `supabase-config.js` prüfen. Wenn ein neues Supabase-Projekt verwendet wird, URL und Anon Key ersetzen.
7. App öffnen und einloggen.

## GitHub Pages veröffentlichen

1. Neues GitHub Repository erstellen.
2. Alle Dateien aus diesem Ordner in das Repository kopieren.
3. Keine `node_modules`, `.git`, Cache- oder Build-Ordner hochladen.
4. Unter **Settings → Pages** als Source den Branch `main` und Ordner `/root` auswählen.
5. Nach Deployment die GitHub-Pages-URL in Supabase Auth URL Configuration ergänzen.
6. Wegen Service Worker nach Updates einmal Hard Refresh durchführen oder die PWA neu starten.

## Datenintegrität

- Supabase ist nach Login die Quelle der Wahrheit.
- Der lokale Speicher überschreibt Remote-Daten nicht automatisch.
- Bettreservierungen verwenden `reserve_bed_for_request(...)` als SQL-RPC mit Row Locks, damit ein freies Bett nicht parallel doppelt reserviert wird.
- Betten werden im UI nicht hart gelöscht, sondern können über Status/Archivlogik weiterentwickelt werden. Die SQL-Struktur enthält `is_archived` für sichere Erweiterung.
- Audit-Events landen in `bed_activity_log`.

## Wichtige Dateien

- `supabase.sql`: zuerst in Supabase ausführen.
- `supabase-config.js`: Projektverbindung prüfen.
- `service-worker.js`: Cache-Version `bedlink-cache-v1-20260529` ist gesetzt.

