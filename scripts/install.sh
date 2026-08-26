#!/usr/bin/env bash
set -e

echo "=== Smart Gateway Server v1.0 ==="

if [ "$EUID" -ne 0 ]; then
  echo "Run as root!"
  exit 1
fi

apt update
apt install -y curl gnupg lsb-release

mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | \
gpg --dearmor -o /usr/share/keyrings/cloudflare-main.gpg

echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared $(lsb_release -cs) main" \
> /etc/apt/sources.list.d/cloudflared.list

apt update
apt install -y cloudflared

mkdir -p /etc/cloudflared
echo "Paste your Tunnel Token:"
read -r TOKEN
echo "$TOKEN" > /etc/cloudflared/token
chmod 600 /etc/cloudflared/token

cat >/etc/systemd/system/cloudflared.service <<EOF
[Unit]
Description=Cloudflare Tunnel
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/cloudflared --protocol http2 --no-autoupdate tunnel run --token-file /etc/cloudflared/token
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable cloudflared
systemctl restart cloudflared

echo "Gateway Installed Successfully!"
systemctl --no-pager status cloudflared