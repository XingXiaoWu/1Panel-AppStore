## Introduction

**Clash for Linux** is a containerized Mihomo proxy service packaged from the upstream clash-for-linux-install Docker setup, with a YACD Web panel.

## Features

- **Proxy Ports**: Provides a mixed HTTP/SOCKS5 proxy port with configurable 1Panel host mappings.
- **Web Control Panel**: Includes YACD and the Mihomo external controller for managing nodes, connections, and logs.
- **Docker Ready**: Joins 1panel-network and retains NET_ADMIN plus /dev/net/tun; TUN is disabled by default and can be enabled in the config file.

Allow the configured controller, YACD panel, mixed proxy, and DNS ports in the server firewall or security group. The YACD panel connects to Mihomo through the controller port; use the Web control secret generated during installation.
