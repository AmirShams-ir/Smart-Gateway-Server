export default { async fetch(request) { const url = new URL(request.url); if (url.pathname === '/health') { return Response.json({ project: 'Smart Gateway Server', status: 'healthy', tunnel: 'connected', version: '1.0.0' }); } return new Response(`<!DOCTYPE html>
<html>
<head>
<title>Smart Gateway Server</title>
<style>
body{font-family:Arial;background:#0f172a;color:#fff;text-align:center;padding:40px}
.card{max-width:600px;margin:auto;background:#1e293b;padding:30px;border-radius:16px}
.ok{color:#22c55e;font-size:22px}
code{background:#334155;padding:4px 8px;border-radius:6px}
</style>
</head>
<body>
<div class="card">
<h1>🍊 Smart Gateway Server</h1>
<p class="ok">Cloudflare Worker Online</p>
<p>Orange Pi Gateway + Cloudflare Tunnel</p>
<p>SSH Host:</p>
<code>ssh.amirshams.ir</code>
<p style="margin-top:30px">Version 1.0</p>
</div>
</body>
</html>`, { headers: { 'content-type': 'text/html;charset=UTF-8' } }); } };