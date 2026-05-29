# Security Setup für BedLink

## Supabase Auth

Die App verwendet den öffentlichen Supabase Anon Key im Browser. Das ist bei Supabase normal. Schutz entsteht durch Auth + Row Level Security, nicht durch Geheimhaltung des Anon Keys.

Empfohlen:

1. Email/Password aktivieren.
2. Öffentliche Signups deaktivieren oder nur kontrolliert einladen.
3. Interne User in Supabase Auth anlegen.
4. In URL Configuration alle erlaubten Redirect URLs pflegen.

## RLS-Modell

`supabase.sql` aktiviert RLS für:

- `hospitals`
- `hospital_beds`
- `bed_reservations`
- `bed_activity_log`

Alle Daten sind für authentifizierte User der gemeinsamen Spital-Koordinationsinstanz sichtbar und pflegbar. Anonyme Nutzer erhalten keinen Remote-Zugriff; die App läuft dann nur im lokalen Demo-Modus.

Für mehrere Organisationen kann das Schema später minimal-invasiv um `organization_id`, Rollen und engere Policies erweitert werden.

## Patientendaten

Die App ist absichtlich auf Referenzen ausgelegt:

- `patient_reference` statt Klarnamen
- kurze operative Notizen
- keine unnötigen personenbezogenen Daten in Audit Logs

Für produktive medizinische Daten müssen Datenschutz-, Rollen-, Logging- und Aufbewahrungsregeln der Organisation geprüft werden.

## GitHub Pages

- Nur statische Dateien veröffentlichen.
- Keine Service Role Keys ins Repository legen.
- Nur den Anon Key im Frontend verwenden.
- Nach Änderungen an HTML/CSS/JS wurde die Service-Worker-Cache-Version erhöht; nach Deployment Hard Refresh/PWA-Neustart durchführen.
