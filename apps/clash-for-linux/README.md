## 产品介绍

**Clash for Linux** 是基于上游 clash-for-linux-install Docker 方案打包的 Mihomo 代理服务，配套 YACD Web 控制面板。

## 主要功能

- **代理端口**：提供 HTTP、SOCKS5 兼容的混合代理端口，并可通过 1Panel 修改宿主机映射端口。
- **Web 控制面板**：内置 YACD 面板与 Mihomo 外部控制器，支持节点、连接和日志管理。
- **Docker 兼容**：加入 1panel-network，并保留 NET_ADMIN 与 /dev/net/tun 能力；默认关闭 TUN，按需在配置文件中开启。

安装后请在服务器防火墙/安全组放行已配置的 Web 控制端口、YACD 面板端口、混合代理端口及 DNS 端口。YACD 面板默认通过控制端口连接 Mihomo；面板访问密钥使用安装时生成的 Web 控制密钥。
