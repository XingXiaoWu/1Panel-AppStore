## Introduction

**WaibibabuClash** is a self-hosted management panel for Mihomo proxy instances, subscriptions and configurations. This package targets Linux ARM64 and includes an offline Docker image.

## Features

- **Container-to-container proxy**: Other containers on `1panel-network` can use `waibibabuclash:<instance proxy port>`. Configure each instance to allow LAN access and listen on `0.0.0.0` or `*`. Proxy ports are not published on the host.
- **Management panel**: The panel has no login authentication and binds to host `127.0.0.1` by default. For remote access, use an authenticated HTTPS reverse proxy or change the bind address after configuring access controls.
- **Persistent data**: Instances, subscriptions, configurations and extracted proxy cores are stored in the app's persistent data directory.

The management panel uses container port `8080`. Proxy ports depend on the Mihomo instance configuration and are not automatically published or mapped by this package.
