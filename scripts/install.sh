#!/usr/bin/env bash
set -Eeuo pipefail

PROJECT_NAME="Smart Gateway Server"
CLOUDFLARED_REPO_FILE="/etc/apt/sources.list.d/cloudflared.list"
CLOUDFLARED_KEYRING="/usr/share/keyrings/cloudflare-main.gpg"
TOKEN_FILE="/etc/cloudflared/token"
SERVICE_FILE="/etc/systemd/system/cloudflared.service"

log() { printf '\n[%s] %s\n' "$PROJECT_NAME" "$1"; }
fail() { echo "ERROR: $1" >&2; exit 1; }

[ "$EUID" -eq 0 ] || fail "Run this script as root (for example: sudo bash install.sh)."

. /etc/os-release
[ "${ID:-}" = "debian" ] || fail "This installer supports Debian only. Detected: ${ID:-unknown}."

ARCH="$(dpkg --print-architecture)"
case "$ARCH" in
  armhf|arm64|amd64|i386)
    ;;
  *)
    fail "Unsupported Debian architecture: $ARCH"
    ;;
esac

CODENAME="${VERSION_CODENAME:-}"
if [ -z "$CODENAME" ]; then
  CODENAME="$(lsb_release -cs 2>/dev/null || true)"
fi
[ -n "$CODENAME" ] || fail "Could not determine Debian release codename."

case "$CODENAME" in
  bookworm|bullseye|buster)
    ;;
  *)
    echo "WARNING: Debian release '$CODENAME' is not explicitly tested by this project. Continuing."
    ;;
esac

log "Detected Debian ${VERSION_ID:-unknown} (${CODENAME}) / ${ARCH}"

log "Installing prerequisites"
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates curl gnupg lsb-release

log "Configuring Cloudflare package repository"
install -d -m 0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg \
  | gpg --dearmor --yes -o "$CLOUDFLARED_KEYRING"
chmod 0644 "$CLOUDFLARED_KEYRING"
printf '%s\n' \
  "deb [signed-by=$CLOUDFLARED_KEYRING] https://pkg.cloudflare.com/cloudflared $CODENAME main" \
  > "$CLOUDFLARED_REPO_FILE"

log "Installing cloudflared"
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y cloudflared

command -v cloudflared >/dev/null 2>&1 || fail "cloudflared installation failed."

log "Configuring tunnel token"
install -d -m 0755 /etc/cloudflared

if [ -z "${CLOUDFLARE_TUNNEL_TOKEN:-}" ]; then
  printf 'Paste your Cloudflare Tunnel token: '
  IFS= read -r CLOUDFLARE_TUNNEL_TOKEN
fi

[ -n "$CLOUDFLARE_TUNNEL_TOKEN" ] || fail "Tunnel token cannot be empty."

printf '%s\n' "$CLOUDFLARE_TUNNEL_TOKEN" > "$TOKEN_FILE"
chmod 0600 "$TOKEN_FILE"

log "Installing systemd service"
cat > "$SERVICE_FILE" <<'EOF'
[Unit]
Description=Cloudflare Tunnel - Smart Gateway Server
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/cloudflared --protocol http2 --no-autoupdate tunnel run --token-file /etc/cloudflared/token
Restart=always
RestartSec=5
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable cloudflared
systemctl restart cloudflared

sleep 2

if ! systemctl is-active --quiet cloudflared; then
  echo
  systemctl --no-pager --full status cloudflared || true
  echo
  echo "Recent logs:"
  journalctl -u cloudflared -n 30 --no-pager || true
  fail "cloudflared did not start successfully."
fi

log "Installation completed successfully"
echo "Architecture : $ARCH"
echo "Debian       : ${VERSION_ID:-unknown} (${CODENAME})"
echo "cloudflared  : $(cloudflared --version 2>/dev/null | head -n1)"
echo "Service      : $(systemctl is-active cloudflared)"
echo "Boot start   : $(systemctl is-enabled cloudflared)"
echo
systemctl --no-pager --full status cloudflared
