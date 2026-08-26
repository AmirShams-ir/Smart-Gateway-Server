#!/usr/bin/env bash

echo "=== Smart Gateway Health Check ==="

echo -n "Service: "
systemctl is-active cloudflared

echo -n "Boot: "
systemctl is-enabled cloudflared

echo -n "Tunnel: "
curl -s http://127.0.0.1:20241/ready

echo
echo "SSH:"
ss -tln | grep ':22' && echo "OK"

echo
echo "Memory:"
free -h