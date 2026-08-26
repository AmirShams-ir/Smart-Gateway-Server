<div align="center">

# 🍊 Smart Gateway Server

### 🌍 A Lightweight, Secure and Intelligent Cloudflare Tunnel Gateway
### powered by **Cloudflared + HTTP/2 + Debian**

[![Deploy to Cloudflare](https://deploy.workers.cloudflare.com/button)](https://deploy.workers.cloudflare.com/?url=https://github.com/AmirShams-ir/Smart-Gateway-Server)

![Linux](https://img.shields.io/badge/Linux-Debian%20%7C%20Armbian-blue?logo=linux)
![Cloudflare](https://img.shields.io/badge/Cloudflare-Tunnel-orange?logo=cloudflare)
![Bash](https://img.shields.io/badge/Bash-100%25-green?logo=gnubash)
![HTTP2](https://img.shields.io/badge/Tunnel-HTTP%2F2-blueviolet)
![License](https://img.shields.io/badge/License-Apache-red)
![Version](https://img.shields.io/badge/version-1.0.0--beta1-success)

**Secure • Lightweight • Zero Port Forward • Dynamic IP Proof**

</div>

---

# ⭐ Highlights

- 🌍 Cloudflare Tunnel Gateway
- 🔒 SSH over HTTPS (HTTP/2)
- 🚫 No Port Forward Required
- 🌐 Dynamic IP Resistant
- ⚡ Optimized for Iran (HTTP/2 instead of QUIC)
- 🪶 Ultra Lightweight (≈10 MB RAM)
- 🖥 Supports Any Debian Architecture
- ❤️ Privacy First

---

# ✨ Features

- 🌍 Cloudflare Named Tunnel
- 🔐 Secure SSH Gateway
- 🚀 HTTP/2 Optimized Connectivity
- 🌐 Automatic Dynamic DNS Handling
- 🛡 Zero Exposed Ports
- 🔄 Auto-Reconnect Tunnel
- ⚙️ Automatic systemd Service
- 📊 Built-in Health Check
- 🪶 Optimized for SBC Devices
- 💾 Pure Bash Installer
- ❤️ Zero Vendor Lock-in Philosophy

---

# 🧠 Why Smart Gateway Server?

Traditional home servers require:

- Static IP
- DDNS
- Port Forward
- DMZ
- Firewall Configuration

**Smart Gateway Server eliminates all of them.**

Your Orange Pi becomes a secure outbound gateway that connects your private LAN to Cloudflare without exposing any inbound ports.

---

# 📸 Dashboard

> Coming Soon

Cloudflare Worker Dashboard will provide:

- Tunnel Status
- Connected Devices
- SSH Hosts
- Health Monitoring
- Live Gateway Statistics

---

# 🖥 Architecture

```text
                 Internet

                     │

          ssh.domain.com

                     │

          Cloudflare Tunnel

               (HTTP/2)

                     │

        🍊 Smart Gateway Server

            Orange Pi / Debian

      ┌──────────┼───────────┐

      │          │           │

   SSH Host   Smart DNS   Smart Proxy

      │          │           │

   Foxconn     WSL2      Raspberry Pi
```

One outbound connection.

Unlimited internal services.

Zero Port Forward.

---

# 📂 Project Structure

```text
Smart-Gateway-Server
│
├── cloudflare/
│   ├── worker.js
│   └── wrangler.jsonc
│
├── scripts/
│   ├── install.sh
│   └── healthcheck.sh
│
├── systemd/
│
├── public/
│
└── README.md
```

---

# 🚀 One-Click Cloudflare Deploy

Click below to automatically deploy the Cloudflare Worker:

[![Deploy to Cloudflare](https://deploy.workers.cloudflare.com/button)](https://deploy.workers.cloudflare.com/?url=https://github.com/AmirShams-ir/Smart-Gateway-Server)

After deployment, create a **Named Tunnel** and copy the generated Tunnel Token.

---

# 🍊 Debian Installation

Supports:

- Debian 12 / 13
- Armbian
- Raspberry Pi OS
- Debian x64
- Thin Clients
- Mini PCs
- VPS

```bash
git clone https://github.com/AmirShams-ir/Smart-Gateway-Server.git

cd Smart-Gateway-Server

chmod +x scripts/*.sh

sudo ./scripts/install.sh
```

Or directly:

```bash
curl -fsSL https://raw.githubusercontent.com/AmirShams-ir/Smart-Gateway-Server/main/scripts/install.sh | sudo bash
```

The installer automatically detects:

- armhf
- arm64
- amd64
- i386

No manual architecture selection required.

---

# 🔍 Health Check

```bash
./scripts/healthcheck.sh
```

Example:

```text
=== Smart Gateway Health Check ===

Service : active

Boot    : enabled

Tunnel  : OK

SSH     : OK

Memory  : 11 MB
```

---

# 🔐 SSH Access

Example SSH configuration:

```sshconfig
Host orangepi
    HostName ssh.domain.com
    User root
    ProxyCommand cloudflared access tcp --hostname %h
```

Connect with:

```bash
ssh orangepi
```

No public port 22 required.

---

# 🛡 Security

Smart Gateway Server follows a Zero-Exposure design.

### ✅ No Port Forward

No inbound ports are opened on the router.

---

### ✅ Dynamic IP Proof

Works behind residential ISPs with changing public IP addresses.

---

### ✅ HTTP/2 Transport

QUIC is often restricted in some regions.

Smart Gateway forces **HTTP/2** for maximum compatibility.

---

### ✅ systemd Recovery

If Tunnel disconnects unexpectedly:

- Automatic Restart
- Boot Persistence
- Health Monitoring

---

# 🌍 Supported Devices

- 🍊 Orange Pi
- 🍓 Raspberry Pi
- 🖥 Intel Thin Client
- 💻 Mini PC
- 🧪 Debian VM
- ☁️ Debian VPS

---

# ❤️ Philosophy

Smart Gateway Server is built around five principles:

- Privacy First
- Zero Port Forward
- Lightweight
- Stability
- Simplicity

Your network stays private.

Only outbound encrypted connections are used.

---

# 🛣 Roadmap

- [x] Cloudflare Tunnel
- [x] HTTP/2 Optimization
- [x] Multi-Architecture Installer
- [x] Health Check
- [x] systemd Auto Recovery
- [x] Debian / Armbian Support
- [ ] Web Dashboard
- [ ] Multi-Host Manager
- [ ] Auto Tunnel Provisioning API
- [ ] Foxconn & WSL Discovery
- [ ] Docker Edition

---

## One-click Deploy

[![Deploy to Cloudflare](https://deploy.workers.cloudflare.com/button)](https://deploy.workers.cloudflare.com/?url=https://github.com/AmirShams-ir/Smart-Gateway-Server)

---

## Server Installation

```bash
curl -fsSL https://raw.githubusercontent.com/AmirShams-ir/Smart-Gateway-Server/main/scripts/install.sh | sudo bash
```

---

# 🤝 Contributions

Pull requests are welcome.

Ideas, issues and improvements are always appreciated.

---

# 📜 License

Apache 2.0 License

---

<div align="center">

### Designed for Orange Pi, Raspberry Pi and Every Debian Server

Made with ❤️ by **AmirShams-ir**

**Smart Gateway • Smart DNS • Smart Proxy**

⭐ Don't forget to Star this project!

</div>