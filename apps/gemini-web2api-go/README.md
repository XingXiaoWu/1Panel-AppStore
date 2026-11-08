## 产品介绍

**Gemini Web2API** 是将 Google Gemini 网页端反代成 OpenAI 兼容 API 的自托管代理服务，同一端口还提供 Gemini 原生接口和 MCP 工具，单个 Go 二进制部署，无需 Google API Key。

## 主要功能

- **OpenAI 兼容接口**：提供 /v1/chat/completions、/v1/models、/v1/responses 等接口，支持真流式、工具调用与 Bearer 鉴权。
- **Gemini 原生接口与 MCP**：同一端口提供 /v1beta/models/{model}:generateContent 原生接口与 MCP 工具，Google SDK 和网关的 Google provider 可直接接入。
- **多模型与媒体生成**：覆盖 Gemini 3.6 Flash、3.5 Flash-Lite、3.1 Pro、3.8 Flash 与 4 Argon 等模型，并支持图片、音乐、画布和视频生成（/v1/videos）。
- **Cookie 池与代理池**：Cookie 池按最久未用优先轮转多个 Google 账号并自动续期，代理池支持增删改、失败熔断与轮转调度，每个出口 IP 独立限流。
- **内置管理面板**：中文管理面板提供概览、请求记录、代理池、Cookie 池、运行时设置与 API Key 轮换，配置保存后立即生效。
- **单二进制与多数据库**：Go 单二进制、distroless 容器镜像，数据可落 SQLite、MySQL 或 PostgreSQL，prompt 与回复内容不入库。
