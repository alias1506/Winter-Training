<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SQL Editor</title>
    <meta name="description" content="Self-hosted SQL Editor — PostgreSQL, MySQL, Oracle" />

    <!-- TailwindCSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
      tailwind.config = {
        darkMode: 'class',
        theme: {
          extend: {
            fontFamily: { sans: ['Inter', 'system-ui', 'sans-serif'] },
            colors: {
              surface: '#0d1117',
              panel: '#161b22',
              border: '#21262d',
              accent: '#1f6feb',
            }
          }
        }
      }
    </script>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&family=JetBrains+Mono:wght@400;500&display=swap"
      rel="stylesheet" />

    <style>
      *,
      *::before,
      *::after {
        box-sizing: border-box;
      }

      body {
        font-family: 'Inter', system-ui, sans-serif;
        background: #0d1117;
        color: #c9d1d9;
      }

      /* SQL textarea */
      #sqlEditor {
        width: 100%;
        height: 240px;
        background: #161b22;
        color: #c9d1d9;
        font-family: 'JetBrains Mono', Consolas, monospace;
        font-size: 13px;
        line-height: 1.7;
        border: none;
        outline: none;
        resize: vertical;
        padding: 12px 16px;
        display: block;
        tab-size: 2;
        border-radius: 0 0 0.75rem 0.75rem;
      }

      #sqlEditor:focus {
        background: #1c2128;
      }

      /* Form inputs */
      .inp {
        background: #0d1117;
        border: 1px solid #21262d;
        color: #c9d1d9;
        border-radius: 6px;
        padding: 5px 10px;
        font-size: 13px;
        width: 100%;
        transition: border-color .15s;
      }

      .inp:focus {
        outline: none;
        border-color: #388bfd;
      }

      select.inp option {
        background: #161b22;
      }

      label {
        font-size: 11px;
        font-weight: 500;
        color: #8b949e;
        letter-spacing: .06em;
        text-transform: uppercase;
        display: block;
        margin-bottom: 3px;
      }

      /* Badges */
      .badge {
        padding: 1px 8px;
        border-radius: 999px;
        font-size: 11px;
        font-weight: 600;
      }

      .b-sel {
        background: #1c2d3f;
        color: #58a6ff;
      }

      .b-dml {
        background: #1a2e1d;
        color: #3fb950;
      }

      .b-ddl {
        background: #2b2210;
        color: #d29922;
      }

      .b-err {
        background: #2d0f0f;
        color: #f85149;
      }

      /* Result table */
      .tbl thead th {
        position: sticky;
        top: 0;
        z-index: 1;
        background: #161b22;
      }

      /* Spinner */
      .spinner {
        width: 14px;
        height: 14px;
        border: 2px solid #30363d;
        border-top-color: #58a6ff;
        border-radius: 50%;
        animation: spin .65s linear infinite;
        display: inline-block;
        vertical-align: middle;
      }

      @keyframes spin {
        to {
          transform: rotate(360deg);
        }
      }

      /* Fade-in */
      .fade {
        animation: fi .2s ease;
      }

      @keyframes fi {
        from {
          opacity: 0;
          transform: translateY(4px);
        }

        to {
          opacity: 1;
        }
      }

      /* Scrollbar */
      ::-webkit-scrollbar {
        width: 6px;
        height: 6px;
      }

      ::-webkit-scrollbar-track {
        background: transparent;
      }

      ::-webkit-scrollbar-thumb {
        background: #30363d;
        border-radius: 3px;
      }
    </style>
  </head>

  <body class="min-h-screen p-4 md:p-6">

    <!-- Header -->
    <header class="flex items-center gap-3 mb-5">
      <div class="w-8 h-8 rounded-lg bg-blue-600 grid place-items-center text-white font-bold text-sm select-none">S
      </div>
      <div>
        <h1 class="text-base font-semibold leading-none tracking-tight">SQL Editor</h1>
        <p class="text-xs text-gray-600 mt-0.5">PostgreSQL · MySQL · Oracle</p>
      </div>
      <span id="pill" class="ml-auto hidden text-xs px-2.5 py-0.5 rounded-full font-medium"></span>
    </header>

    <!-- Layout -->
    <div class="grid grid-cols-1 xl:grid-cols-[300px_1fr] gap-4">

      <!-- Connection Sidebar -->
      <aside class="bg-panel border border-border rounded-xl p-4 flex flex-col gap-3 self-start">
        <p class="text-[11px] font-semibold text-gray-600 uppercase tracking-widest">Connection</p>

        <div>
          <label for="dbType">Database</label>
          <select id="dbType" class="inp" onchange="onDbChange()">
            <option value="postgresql">PostgreSQL</option>
            <option value="mysql">MySQL</option>
            <option value="oracle">Oracle</option>
          </select>
        </div>

        <div class="grid grid-cols-[1fr_72px] gap-2">
          <div>
            <label for="host">Host</label>
            <input id="host" class="inp" type="text" value="192.168.137.84" placeholder="localhost" />
          </div>
          <div>
            <label for="port">Port</label>
            <input id="port" class="inp" type="number" value="5432" />
          </div>
        </div>

        <div>
          <label for="dbName" id="dbLabel">Database</label>
          <input id="dbName" class="inp" type="text" value="winter_training" placeholder="database / SID" />
        </div>

        <div>
          <label for="username">Username</label>
          <input id="username" class="inp" type="text" value="soham" />
        </div>

        <div>
          <label for="password">Password</label>
          <input id="password" class="inp" type="password" value="admin" />
        </div>

        <div id="connMsg" class="text-xs text-gray-600 min-h-[14px]"></div>
      </aside>

      <!-- Editor + Results -->
      <main class="flex flex-col gap-4 min-w-0">

        <!-- Editor Card -->
        <div class="bg-panel border border-border rounded-xl overflow-hidden">
          <!-- Toolbar -->
          <div class="flex items-center justify-between px-3 py-2 border-b border-border">
            <span class="text-xs text-gray-600 font-mono">query.sql</span>
            <div class="flex gap-2 items-center">
              <span class="text-[10px] text-gray-700">Ctrl+Enter to run</span>
              <button onclick="clearEditor()"
                class="text-xs px-3 py-1 rounded border border-border text-gray-500 hover:text-gray-300 hover:border-gray-500 transition">
                Clear
              </button>
              <button id="runBtn" onclick="runQuery()"
                class="text-xs px-4 py-1.5 rounded bg-blue-700 hover:bg-blue-600 text-white font-semibold transition flex items-center gap-1.5">
                <span id="runLabel">&#9654; Run</span>
              </button>
            </div>
          </div>
          <textarea id="sqlEditor" spellcheck="false" autocorrect="off" autocapitalize="off"
            placeholder="-- Write your SQL here&#10;SELECT NOW();">-- Write your SQL here
SELECT NOW();</textarea>
        </div>

        <!-- Results area -->
        <div id="results" class="flex flex-col gap-3">
          <div id="resultsPlaceholder"
            class="bg-panel border border-border rounded-xl px-4 py-10 text-center text-sm text-gray-600">
            &#9654; Run a query to see results here
          </div>
        </div>

      </main>
    </div>

    <!-- Scripts -->
    <script>
      const PORTS = { postgresql: '5432', mysql: '3306', oracle: '1521' };
      const LABELS = { postgresql: 'Database', mysql: 'Database', oracle: 'Service / SID' };

      function onDbChange() {
        var db = document.getElementById('dbType').value;
        document.getElementById('port').value = PORTS[db];
        document.getElementById('dbLabel').textContent = LABELS[db];
      }

      /* ── Editor helpers ── */
      function clearEditor() {
        document.getElementById('sqlEditor').value = '';
        document.getElementById('sqlEditor').focus();
      }

      /* Ctrl/Cmd+Enter to run */
      document.getElementById('sqlEditor').addEventListener('keydown', function (e) {
        if (e.key === 'Enter' && (e.ctrlKey || e.metaKey)) {
          e.preventDefault();
          runQuery();
        }
        /* Tab inserts spaces */
        if (e.key === 'Tab') {
          e.preventDefault();
          var s = this.selectionStart, end = this.selectionEnd;
          this.value = this.value.substring(0, s) + '  ' + this.value.substring(end);
          this.selectionStart = this.selectionEnd = s + 2;
        }
      });

      /* ── Run Query ── */
      async function runQuery() {
        var sql = document.getElementById('sqlEditor').value.trim();
        if (!sql) { flashMsg('No SQL to execute.'); return; }

        var dbType = document.getElementById('dbType').value;
        var host = document.getElementById('host').value.trim();
        var port = document.getElementById('port').value.trim();
        var database = document.getElementById('dbName').value.trim();
        var user = document.getElementById('username').value.trim();
        var password = document.getElementById('password').value;

        setRunning(true);
        document.getElementById('results').innerHTML = '';
        document.getElementById('connMsg').textContent = '';

        try {
          var ctxPath = '<%= request.getContextPath() %>';
          if (ctxPath === '/') ctxPath = '';

          var res = await fetch(ctxPath + '/sqleditor/' + dbType, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ host: host, port: port, user: user, password: password, database: database, sql: sql })
          });

          var json = await res.json();

          if (!res.ok) {
            showGlobalError(json.error || 'HTTP ' + res.status);
            setPill(false, '');
            return;
          }

          renderAll(json.results || []);
          setPill(true, dbType + ' · ' + host + ':' + port + '/' + database);

        } catch (e) {
          showGlobalError('Network error — ' + e.message);
          setPill(false, '');
        } finally {
          setRunning(false);
        }
      }

      /* ── Render result cards ── */
      function renderAll(results) {
        var wrap = document.getElementById('results');
        wrap.innerHTML = '';
        if (!results.length) {
          wrap.innerHTML = '<div class="bg-panel border border-border rounded-xl px-4 py-8 text-center text-sm text-gray-600">No results returned.</div>';
          return;
        }
        results.forEach(function (r, i) { wrap.appendChild(makeCard(r, i + 1)); });
      }

      function makeCard(r, idx) {
        var card = document.createElement('div');
        card.className = 'bg-panel border border-border rounded-xl overflow-hidden fade';

        var badge = '', body = '';

        switch (r.type) {
          case 'select':
            badge = '<span class="badge b-sel">SELECT</span> <span class="text-xs text-gray-600 ml-1">' + r.rowCount + ' row' + (r.rowCount != 1 ? 's' : '') + '</span>';
            body = makeTable(r.columns, r.rows);
            break;
          case 'dml':
            badge = '<span class="badge b-dml">DML</span>';
            body = '<div class="px-4 py-3 text-sm text-green-400">&#10003; <strong>' + r.rowsAffected + '</strong> row' + (r.rowsAffected != 1 ? 's' : '') + ' affected</div>';
            break;
          case 'ddl':
            badge = '<span class="badge b-ddl">DDL</span>';
            body = '<div class="px-4 py-3 text-sm text-yellow-400">&#10003; ' + esc(r.message) + '</div>';
            break;
          default:
            badge = '<span class="badge b-err">ERROR</span>';
            body = '<div class="px-4 py-3 text-sm text-red-400 font-mono whitespace-pre-wrap">&#10005; ' + esc(r.message) + '</div>';
        }

        card.innerHTML =
          '<div class="flex items-center gap-2 px-3 py-2 border-b border-border bg-[#0d1117]">' +
          '<span class="text-[11px] text-gray-600">#' + idx + '</span>' + badge +
          '</div>' + body;

        return card;
      }

      function makeTable(cols, rows) {
        if (!cols || !cols.length) return '<div class="px-4 py-3 text-xs text-gray-600">No columns.</div>';

        var th = cols.map(function (c) {
          return '<th class="px-3 py-2 text-left text-xs font-semibold text-gray-500 border-b border-border whitespace-nowrap">' + esc(c) + '</th>';
        }).join('');

        var trs = (rows || []).map(function (row) {
          var tds = row.map(function (v) {
            return '<td class="px-3 py-1.5 text-xs font-mono text-gray-300 border-b border-border whitespace-nowrap max-w-xs truncate">' +
              (v === null ? '<span class="text-gray-600 italic">NULL</span>' : esc(String(v))) +
              '</td>';
          }).join('');
          return '<tr class="hover:bg-white/[.03] transition">' + tds + '</tr>';
        }).join('');

        return '<div class="overflow-auto max-h-64"><table class="tbl w-full border-collapse"><thead><tr>' + th + '</tr></thead><tbody>' + trs + '</tbody></table></div>';
      }

      /* ── UI helpers ── */
      function setRunning(on) {
        var btn = document.getElementById('runBtn');
        document.getElementById('runLabel').innerHTML = on ? '<span class="spinner"></span> Running&hellip;' : '&#9654; Run';
        btn.disabled = on;
        btn.classList.toggle('opacity-60', on);
      }

      function setPill(ok, text) {
        var p = document.getElementById('pill');
        p.className = 'ml-auto text-xs px-2.5 py-0.5 rounded-full font-medium ' + (ok ? 'bg-green-900/40 text-green-400' : 'bg-red-900/40 text-red-400');
        p.textContent = ok ? '\u25cf ' + text : '\u25cf disconnected';
      }

      function showGlobalError(msg) {
        var d = document.createElement('div');
        d.className = 'bg-red-950/40 border border-red-900/40 rounded-xl px-4 py-3 text-sm text-red-400 font-mono fade';
        d.textContent = '\u2715 ' + msg;
        document.getElementById('results').appendChild(d);
      }

      function flashMsg(msg) {
        document.getElementById('connMsg').textContent = msg;
      }

      function esc(s) {
        return String(s)
          .replace(/&/g, '&amp;').replace(/</g, '&lt;')
          .replace(/>/g, '&gt;').replace(/"/g, '&quot;');
      }
    </script>
  </body>

  </html>