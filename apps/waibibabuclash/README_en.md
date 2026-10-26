## Introduction

**WaibibabuClash** is a self-hosted multi-instance Mihomo control panel with instance management, run overview, proxy groups, active connections, rules, YAML configuration, and a REST API console. This package uses the officially published Docker image and targets Linux ARM64 hosts only.

## Features

- **Multi-instance Management**: Start, stop, and restart each instance independently with its own proxy and controller ports, and switch between rule, global, and direct modes.
- **Subscriptions and Configuration**: Maintain shared full configurations and node subscription catalogs that multiple instances can reference; edit raw YAML and configure IPv6 and DNS visually.
- **Container-to-container proxy**: Other containers on `1panel-network` can use `waibibabuclash:<instance proxy port>`. Configure each instance to allow LAN access and listen on `0.0.0.0` or `*`. Proxy ports are not published on the host.
- **Management panel**: The panel has no login authentication and binds to host `127.0.0.1` by default. For remote access, use an authenticated HTTPS reverse proxy or change the bind address after configuring access controls.
- **Persistent data**: Instances, subscriptions, configurations and extracted proxy cores are stored in the `WaibibabuClash` subdirectory of the app's persistent data directory.

The management panel uses container port `8080`, and the host port is chosen by the Web UI port parameter during installation. Proxy ports depend on the Mihomo instance configuration and are not automatically published or mapped by this package.
