:root {
  color-scheme: dark;
  --bg: #07131d;
  --bg-soft: #0c2030;
  --surface: rgba(14, 31, 45, 0.78);
  --surface-strong: rgba(18, 42, 60, 0.94);
  --line: rgba(184, 211, 225, 0.14);
  --line-strong: rgba(184, 211, 225, 0.24);
  --text: #ecf8ff;
  --muted: #98adbb;
  --muted-strong: #bed0dc;
  --primary: #19a8cf;
  --primary-strong: #0f86b2;
  --secondary: #39c6a3;
  --danger: #ef6b73;
  --warn: #f2b84b;
  --info: #72a7ff;
  --good: #49d491;
  --reserved: #28b6c8;
  --shadow: 0 24px 80px rgba(0, 0, 0, 0.36);
  --radius-xl: 28px;
  --radius-lg: 20px;
  --radius-md: 14px;
  --radius-sm: 10px;
  --font: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
}

:root[data-theme="light"] {
  color-scheme: light;
  --bg: #edf4f8;
  --bg-soft: #f7fbfd;
  --surface: rgba(255, 255, 255, 0.82);
  --surface-strong: rgba(255, 255, 255, 0.96);
  --line: rgba(23, 51, 70, 0.12);
  --line-strong: rgba(23, 51, 70, 0.2);
  --text: #102234;
  --muted: #617283;
  --muted-strong: #35495c;
  --shadow: 0 24px 70px rgba(23, 51, 70, 0.14);
}

* { box-sizing: border-box; }
html { min-height: 100%; background: var(--bg); }
body {
  min-height: 100vh;
  margin: 0;
  color: var(--text);
  font-family: var(--font);
  background:
    radial-gradient(circle at 14% 10%, rgba(25, 168, 207, 0.28), transparent 34rem),
    radial-gradient(circle at 85% 12%, rgba(57, 198, 163, 0.18), transparent 28rem),
    linear-gradient(145deg, var(--bg), var(--bg-soft));
  -webkit-font-smoothing: antialiased;
}

button, input, select, textarea { font: inherit; }
button { cursor: pointer; }
code { font-family: "SFMono-Regular", Consolas, "Liberation Mono", monospace; font-size: 0.92em; }

.app-shell {
  width: min(1440px, 100%);
  margin: 0 auto;
  padding: 22px clamp(16px, 2vw, 30px) 32px;
}

.glass {
  background: var(--surface);
  border: 1px solid var(--line);
  box-shadow: var(--shadow);
  backdrop-filter: blur(24px);
}

.glass-ish {
  background: rgba(255, 255, 255, 0.045);
  border: 1px solid var(--line);
  box-shadow: 0 16px 40px rgba(0, 0, 0, 0.16);
}

:root[data-theme="light"] .glass-ish { background: rgba(255, 255, 255, 0.72); }

.topbar {
  position: sticky;
  top: 14px;
  z-index: 20;
  display: grid;
  grid-template-columns: auto 1fr auto;
  gap: 18px;
  align-items: center;
  padding: 12px 14px;
  border-radius: 24px;
}

.brand {
  display: inline-flex;
  align-items: center;
  gap: 12px;
  min-width: 230px;
  color: var(--text);
  text-decoration: none;
}
.brand-mark {
  display: grid;
  place-items: center;
  width: 42px;
  height: 42px;
  border-radius: 13px;
  color: white;
  font-weight: 900;
  font-size: 30px;
  line-height: 1;
  background: linear-gradient(145deg, #075a74, #18a9cd);
  box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.32), 0 12px 28px rgba(25, 168, 207, 0.35);
}
.brand strong { display: block; font-size: 1.1rem; letter-spacing: 0.01em; }
.brand small { color: var(--muted); font-weight: 650; }

.top-nav {
  justify-self: center;
  display: flex;
  gap: 6px;
  padding: 5px;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.055);
  border: 1px solid var(--line);
}
.nav-link {
  border: 0;
  border-radius: 999px;
  background: transparent;
  color: var(--muted-strong);
  padding: 10px 16px;
  font-weight: 750;
}
.nav-link.active {
  color: #fff;
  background: linear-gradient(135deg, var(--primary), var(--primary-strong));
  box-shadow: 0 12px 24px rgba(25, 168, 207, 0.25);
}
:root[data-theme="light"] .nav-link.active { color: #fff; }

.top-actions { display: flex; align-items: center; justify-content: flex-end; gap: 10px; }
.connection-badge {
  display: inline-flex;
  align-items: center;
  min-height: 34px;
  padding: 7px 11px;
  border-radius: 999px;
  background: rgba(242, 184, 75, 0.12);
  border: 1px solid rgba(242, 184, 75, 0.26);
  color: var(--warn);
  font-weight: 800;
  font-size: 0.82rem;
  white-space: nowrap;
}
.connection-badge.live {
  color: var(--good);
  background: rgba(73, 212, 145, 0.12);
  border-color: rgba(73, 212, 145, 0.24);
}
.connection-badge.warn {
  color: var(--danger);
  background: rgba(239, 107, 115, 0.12);
  border-color: rgba(239, 107, 115, 0.24);
}

.pill, .icon-btn, .mini-btn, .status-action, .text-btn, .quick-action, .segment {
  border: 1px solid var(--line);
  color: var(--text);
  background: rgba(255, 255, 255, 0.06);
  transition: transform 0.18s ease, border-color 0.18s ease, background 0.18s ease, box-shadow 0.18s ease;
}
.pill:hover, .icon-btn:hover, .mini-btn:hover, .status-action:hover, .quick-action:hover, .segment:hover {
  transform: translateY(-1px);
  border-color: var(--line-strong);
}
.pill {
  min-height: 40px;
  padding: 9px 15px;
  border-radius: 999px;
  font-weight: 850;
  white-space: nowrap;
}
.pill.large { min-height: 48px; padding-inline: 20px; }
.pill.primary, .mini-btn.primary {
  color: white;
  border-color: rgba(25, 168, 207, 0.42);
  background: linear-gradient(135deg, var(--primary), var(--primary-strong));
  box-shadow: 0 16px 30px rgba(25, 168, 207, 0.24);
}
.pill.secondary {
  color: #eafff8;
  border-color: rgba(57, 198, 163, 0.42);
  background: linear-gradient(135deg, var(--secondary), #1b977f);
  box-shadow: 0 16px 30px rgba(57, 198, 163, 0.19);
}
.pill.ghost { background: rgba(255, 255, 255, 0.04); }
.icon-btn {
  display: inline-grid;
  place-items: center;
  width: 40px;
  height: 40px;
  border-radius: 14px;
  font-size: 1.1rem;
}
.icon-btn.subtle { width: 34px; height: 34px; border-radius: 12px; color: var(--muted-strong); }
.text-btn {
  border: 0;
  background: transparent;
  color: var(--primary);
  font-weight: 850;
  padding: 4px;
}
.mini-btn {
  min-height: 34px;
  padding: 7px 11px;
  border-radius: 12px;
  font-weight: 800;
}
.mini-btn.danger { color: var(--danger); border-color: rgba(239, 107, 115, 0.24); }

.main-grid {
  display: grid;
  grid-template-columns: minmax(0, 1fr) 360px;
  gap: 16px;
  margin-top: 16px;
  align-items: start;
}
.workspace { min-width: 0; }
.screen { display: none; }
.screen.active { display: block; }

.hero-card {
  display: grid;
  grid-template-columns: minmax(0, 1fr) 210px;
  gap: 18px;
  align-items: stretch;
  min-height: 270px;
  padding: clamp(24px, 4vw, 44px);
  border-radius: var(--radius-xl);
  overflow: hidden;
  position: relative;
}
.hero-card::after {
  content: "";
  position: absolute;
  inset: auto -8% -42% 42%;
  height: 240px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(25, 168, 207, 0.32), transparent 62%);
  pointer-events: none;
}
.eyebrow {
  margin: 0 0 9px;
  color: var(--secondary);
  text-transform: uppercase;
  letter-spacing: 0.13em;
  font-size: 0.72rem;
  font-weight: 900;
}
h1, h2, h3, p { margin-top: 0; }
.hero-copy h1 {
  max-width: 780px;
  margin-bottom: 14px;
  font-size: clamp(2rem, 4vw, 4rem);
  line-height: 0.98;
  letter-spacing: -0.055em;
}
.hero-copy p:not(.eyebrow) {
  max-width: 690px;
  margin-bottom: 24px;
  color: var(--muted-strong);
  font-size: 1.05rem;
  line-height: 1.55;
}
.hero-actions { display: flex; flex-wrap: wrap; gap: 12px; }
.hero-status {
  align-self: center;
  display: grid;
  place-items: center;
  min-height: 190px;
  border-radius: 24px;
  border: 1px solid var(--line);
  background: linear-gradient(145deg, rgba(25, 168, 207, 0.14), rgba(57, 198, 163, 0.08));
}
.hero-status strong { font-size: 4rem; line-height: 1; letter-spacing: -0.06em; }
.hero-status small { color: var(--muted); font-weight: 800; }
.pulse-dot {
  width: 12px;
  height: 12px;
  border-radius: 999px;
  background: var(--good);
  box-shadow: 0 0 0 8px rgba(73, 212, 145, 0.12);
}

.kpi-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 14px;
  margin: 16px 0;
}
.metric-card {
  display: flex;
  gap: 14px;
  align-items: center;
  padding: 18px;
  border-radius: 22px;
}
.metric-icon {
  display: grid;
  place-items: center;
  width: 46px;
  height: 46px;
  border-radius: 16px;
  color: #eaffff;
  background: rgba(25, 168, 207, 0.18);
  border: 1px solid rgba(25, 168, 207, 0.28);
}
.metric-label { display: block; color: var(--muted); font-size: 0.82rem; font-weight: 800; }
.metric-card strong { display: block; margin: 2px 0 1px; font-size: 1.8rem; letter-spacing: -0.04em; }
.metric-card small { color: var(--muted); font-weight: 700; }

.panel, .screen-head {
  border-radius: var(--radius-xl);
  padding: 20px;
  margin-bottom: 16px;
}
.screen-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 20px;
}
.screen-head h1, .panel-head h2 { margin-bottom: 8px; letter-spacing: -0.035em; }
.screen-head p:not(.eyebrow) { color: var(--muted); max-width: 760px; margin-bottom: 0; line-height: 1.5; }
.panel-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  margin-bottom: 16px;
}
.panel-head h2 { margin: 0; }
.section-head.compact { display: flex; align-items: center; justify-content: space-between; gap: 10px; margin-bottom: 12px; }
.section-head.compact h2 { font-size: 1.05rem; margin: 0; }

.segmented {
  display: flex;
  gap: 6px;
  flex-wrap: wrap;
  padding: 5px;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.045);
  border: 1px solid var(--line);
}
.segment {
  min-height: 34px;
  padding: 7px 11px;
  border-radius: 999px;
  font-weight: 800;
  color: var(--muted-strong);
  background: transparent;
}
.segment.active { color: #fff; background: rgba(25, 168, 207, 0.84); border-color: transparent; }

.hospital-list { display: grid; gap: 10px; }
.hospital-row {
  display: grid;
  grid-template-columns: 44px minmax(190px, 1fr) 82px 70px 86px 130px minmax(160px, auto) auto;
  gap: 12px;
  align-items: center;
  padding: 14px;
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.038);
  border: 1px solid var(--line);
}
.hospital-icon {
  display: grid;
  place-items: center;
  width: 42px;
  height: 42px;
  border-radius: 13px;
  color: var(--primary);
  background: rgba(25, 168, 207, 0.12);
}
.hospital-main strong { display: block; font-size: 1rem; }
.hospital-main span, .hospital-stat small { color: var(--muted); font-weight: 700; font-size: 0.82rem; }
.hospital-stat strong { display: block; font-size: 1.25rem; letter-spacing: -0.03em; }
.text-good { color: var(--good); }
.hospital-progress {
  height: 10px;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.08);
  overflow: hidden;
}
.hospital-progress span { display: block; height: 100%; border-radius: inherit; background: linear-gradient(90deg, var(--secondary), var(--primary)); }
.hospital-tags, .feature-row, .bed-meta, .request-meta { display: flex; flex-wrap: wrap; gap: 7px; }
.row-actions, .request-actions { display: flex; flex-wrap: wrap; justify-content: flex-end; gap: 8px; }
.chip {
  display: inline-flex;
  align-items: center;
  min-height: 26px;
  padding: 4px 8px;
  border-radius: 999px;
  color: var(--muted-strong);
  background: rgba(255, 255, 255, 0.07);
  border: 1px solid var(--line);
  font-size: 0.76rem;
  font-weight: 800;
}
.chip-warn { color: var(--warn); background: rgba(242, 184, 75, 0.11); border-color: rgba(242, 184, 75, 0.22); }
.chip-muted { color: var(--muted); }

.side-panel {
  position: sticky;
  top: 104px;
  border-radius: var(--radius-xl);
  padding: 18px;
  max-height: calc(100vh - 124px);
  overflow: auto;
}
.side-section + .side-section { margin-top: 20px; padding-top: 18px; border-top: 1px solid var(--line); }
.field { display: grid; gap: 7px; margin-bottom: 12px; }
.field span, .feature-box legend {
  color: var(--muted-strong);
  font-size: 0.82rem;
  font-weight: 850;
}
.field input, .field select, .field textarea {
  width: 100%;
  min-height: 44px;
  color: var(--text);
  background: rgba(255, 255, 255, 0.065);
  border: 1px solid var(--line);
  border-radius: 14px;
  padding: 10px 12px;
  outline: none;
}
.field textarea { resize: vertical; min-height: 96px; }
.field input:focus, .field select:focus, .field textarea:focus { border-color: rgba(25, 168, 207, 0.6); box-shadow: 0 0 0 4px rgba(25, 168, 207, 0.12); }
:root[data-theme="light"] .field input, :root[data-theme="light"] .field select, :root[data-theme="light"] .field textarea { background: rgba(255, 255, 255, 0.88); }
.quick-action {
  display: flex;
  justify-content: space-between;
  gap: 10px;
  width: 100%;
  min-height: 48px;
  margin-bottom: 8px;
  padding: 12px;
  border-radius: 16px;
  font-weight: 850;
  text-align: left;
}
.quick-action strong { color: var(--primary); }

.bed-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(310px, 1fr));
  gap: 14px;
}
.bed-card, .request-card {
  padding: 16px;
  border-radius: 22px;
}
.bed-card-head, .request-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
  margin-bottom: 13px;
}
.status-pill, .priority-pill {
  display: inline-flex;
  align-items: center;
  min-height: 28px;
  padding: 5px 10px;
  border-radius: 999px;
  font-size: 0.75rem;
  font-weight: 950;
  border: 1px solid transparent;
}
.status-pill.good { color: var(--good); background: rgba(73, 212, 145, 0.13); border-color: rgba(73, 212, 145, 0.25); }
.status-pill.reserved { color: var(--reserved); background: rgba(40, 182, 200, 0.13); border-color: rgba(40, 182, 200, 0.25); }
.status-pill.busy { color: #d9b4ff; background: rgba(170, 115, 255, 0.14); border-color: rgba(170, 115, 255, 0.25); }
.status-pill.warn { color: var(--warn); background: rgba(242, 184, 75, 0.13); border-color: rgba(242, 184, 75, 0.25); }
.status-pill.danger { color: var(--danger); background: rgba(239, 107, 115, 0.13); border-color: rgba(239, 107, 115, 0.25); }
.status-pill.info { color: var(--info); background: rgba(114, 167, 255, 0.13); border-color: rgba(114, 167, 255, 0.25); }
.priority-pill.low { color: var(--muted-strong); background: rgba(255, 255, 255, 0.06); }
.priority-pill.normal { color: var(--info); background: rgba(114, 167, 255, 0.13); }
.priority-pill.urgent { color: var(--warn); background: rgba(242, 184, 75, 0.13); }
.priority-pill.emergency { color: var(--danger); background: rgba(239, 107, 115, 0.13); }
.bed-title strong, .request-title strong { display: block; font-size: 1.16rem; letter-spacing: -0.03em; }
.bed-title span, .request-title span { display: block; color: var(--muted); font-weight: 750; margin-top: 3px; }
.bed-meta, .request-meta { margin: 12px 0; color: var(--muted); font-size: 0.8rem; font-weight: 800; }
.bed-meta span, .request-meta span { padding-right: 8px; border-right: 1px solid var(--line); }
.bed-meta span:last-child, .request-meta span:last-child { border-right: 0; }
.bed-note { margin: 12px 0 0; color: var(--muted-strong); font-size: 0.88rem; line-height: 1.45; }
.muted { color: var(--muted) !important; }
.status-actions {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 7px;
  margin-top: 14px;
}
.status-action {
  min-height: 34px;
  border-radius: 12px;
  color: var(--muted-strong);
  font-size: 0.76rem;
  font-weight: 850;
}
.status-action.active { color: white; background: rgba(25, 168, 207, 0.78); border-color: transparent; }

.match-board, .request-list { display: grid; gap: 12px; }
.request-card { position: relative; overflow: hidden; }
.request-card.emergency::before, .request-card.urgent::before {
  content: "";
  position: absolute;
  inset: 0 auto 0 0;
  width: 4px;
  background: var(--danger);
}
.request-card.urgent::before { background: var(--warn); }
.match-strip {
  display: grid;
  grid-template-columns: auto 1fr auto;
  gap: 10px;
  align-items: center;
  margin-top: 14px;
  padding: 10px;
  border-radius: 16px;
  background: rgba(73, 212, 145, 0.1);
  border: 1px solid rgba(73, 212, 145, 0.18);
}
.match-strip strong { color: var(--good); font-size: 1.3rem; }
.match-strip span { color: var(--muted-strong); font-weight: 850; }
.match-strip.empty { background: rgba(239, 107, 115, 0.1); border-color: rgba(239, 107, 115, 0.18); }
.match-strip.empty strong { color: var(--danger); }
.request-actions { margin-top: 12px; }

.activity-feed { display: grid; gap: 12px; }
.activity-item { display: grid; grid-template-columns: 14px 1fr; gap: 10px; align-items: start; }
.activity-dot { width: 10px; height: 10px; margin-top: 5px; border-radius: 999px; background: var(--primary); box-shadow: 0 0 0 6px rgba(25, 168, 207, 0.12); }
.activity-item strong { display: block; font-size: 0.9rem; }
.activity-item span, .activity-item small { display: block; color: var(--muted); font-size: 0.78rem; font-weight: 750; }

.setup-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 16px;
}
.setup-card h2 { margin-bottom: 10px; }
.setup-steps { margin: 0; padding-left: 22px; color: var(--muted-strong); line-height: 1.7; }
.schema-chips { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 16px; }
.schema-chips span { padding: 8px 10px; border-radius: 999px; background: rgba(25, 168, 207, 0.12); color: var(--primary); font-weight: 850; }
.sql-preview {
  max-height: 520px;
  overflow: auto;
  padding: 18px;
  border-radius: 22px;
  color: var(--muted-strong);
  background: rgba(0, 0, 0, 0.28);
  border: 1px solid var(--line);
  white-space: pre-wrap;
  line-height: 1.45;
}
:root[data-theme="light"] .sql-preview { background: rgba(4, 18, 27, 0.06); }

.modal {
  width: min(760px, calc(100vw - 28px));
  padding: 0;
  border: 0;
  color: var(--text);
  background: transparent;
}
.modal::backdrop { background: rgba(2, 8, 14, 0.72); backdrop-filter: blur(7px); }
.modal-card {
  padding: 20px;
  border-radius: 28px;
  background: var(--surface-strong);
  border: 1px solid var(--line-strong);
  box-shadow: var(--shadow);
}
.modal-card.narrow { width: min(480px, 100%); margin: 0 auto; }
.modal-head { display: flex; align-items: flex-start; justify-content: space-between; gap: 16px; margin-bottom: 18px; }
.modal-head h2 { margin: 0; }
.form-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 12px; }
.feature-box {
  margin: 4px 0 14px;
  padding: 12px;
  border: 1px solid var(--line);
  border-radius: 18px;
}
.feature-checks { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 8px; margin-top: 8px; }
.check-card {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px;
  border-radius: 14px;
  border: 1px solid var(--line);
  background: rgba(255, 255, 255, 0.045);
  color: var(--muted-strong);
  font-weight: 850;
}
.check-card input { accent-color: var(--primary); }
.modal-actions {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 10px;
  margin-top: 16px;
}
.modal-actions.split { justify-content: space-between; }

.empty-state {
  display: grid;
  place-items: center;
  min-height: 180px;
  padding: 26px;
  text-align: center;
  color: var(--muted);
  border: 1px dashed var(--line-strong);
  border-radius: 22px;
  background: rgba(255, 255, 255, 0.035);
}
.empty-state strong { color: var(--text); font-size: 1.05rem; }
.empty-state p { max-width: 460px; margin: 8px 0 0; line-height: 1.5; }
.empty-icon { display: grid; place-items: center; width: 48px; height: 48px; margin-bottom: 12px; border-radius: 16px; color: var(--primary); background: rgba(25, 168, 207, 0.12); }
.toast {
  position: fixed;
  right: 20px;
  bottom: 20px;
  z-index: 100;
  max-width: min(420px, calc(100vw - 40px));
  padding: 14px 16px;
  border-radius: 18px;
  color: var(--text);
  background: var(--surface-strong);
  border: 1px solid var(--line-strong);
  box-shadow: var(--shadow);
  font-weight: 850;
}
.toast.success { border-color: rgba(73, 212, 145, 0.32); }
.toast.warn { border-color: rgba(242, 184, 75, 0.32); }
.toast.error { border-color: rgba(239, 107, 115, 0.32); }
.hidden { display: none !important; }

@media (max-width: 1180px) {
  .main-grid { grid-template-columns: 1fr; }
  .side-panel { position: static; max-height: none; order: -1; }
  .side-section { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 10px; }
  .side-section .section-head { grid-column: 1 / -1; }
  .topbar { grid-template-columns: 1fr; }
  .top-nav { justify-self: stretch; overflow-x: auto; }
  .top-actions { justify-content: flex-start; flex-wrap: wrap; }
  .hospital-row { grid-template-columns: 44px minmax(180px, 1fr) repeat(3, 72px); }
  .hospital-progress, .hospital-tags, .row-actions { grid-column: 2 / -1; }
  .row-actions { justify-content: flex-start; }
}

@media (max-width: 780px) {
  .app-shell { padding: 12px 10px 90px; }
  .topbar { top: 8px; border-radius: 20px; }
  .brand { min-width: 0; }
  .brand small { display: none; }
  .top-nav { justify-content: flex-start; padding: 4px; }
  .nav-link { padding: 9px 12px; }
  .hero-card { grid-template-columns: 1fr; min-height: 0; padding: 22px; border-radius: 24px; }
  .hero-copy h1 { font-size: clamp(2rem, 12vw, 3.2rem); }
  .hero-status { min-height: 150px; }
  .kpi-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 10px; }
  .metric-card { padding: 14px; border-radius: 18px; }
  .metric-icon { width: 38px; height: 38px; border-radius: 14px; }
  .metric-card strong { font-size: 1.45rem; }
  .screen-head, .panel-head { align-items: flex-start; flex-direction: column; }
  .panel, .screen-head { padding: 16px; border-radius: 22px; }
  .segmented { width: 100%; overflow-x: auto; flex-wrap: nowrap; border-radius: 18px; }
  .hospital-row { grid-template-columns: 40px 1fr 64px; gap: 10px; }
  .hospital-stat:nth-of-type(2), .hospital-stat:nth-of-type(3) { grid-column: auto; }
  .hospital-progress, .hospital-tags, .row-actions { grid-column: 1 / -1; }
  .hospital-main span { display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
  .side-section { grid-template-columns: 1fr; }
  .bed-grid { grid-template-columns: 1fr; }
  .setup-grid, .form-grid { grid-template-columns: 1fr; }
  .feature-checks { grid-template-columns: 1fr 1fr; }
  .status-actions { grid-template-columns: repeat(2, minmax(0, 1fr)); }
  .match-strip { grid-template-columns: auto 1fr; }
  .match-strip .mini-btn { grid-column: 1 / -1; }
  .modal-actions { flex-direction: column-reverse; align-items: stretch; }
  .modal-actions.split { align-items: stretch; }
  .modal-actions .pill, .modal-actions .text-btn { width: 100%; }
}

@media (max-width: 460px) {
  .kpi-grid { grid-template-columns: 1fr; }
  .feature-checks { grid-template-columns: 1fr; }
  .top-actions .pill, .top-actions .connection-badge { flex: 1 1 auto; justify-content: center; }
}
