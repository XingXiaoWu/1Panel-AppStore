## Introduction

**Gemini Web2API** is a self-hosted proxy that turns the Google Gemini web app into an OpenAI-compatible API, serving the native Gemini API and MCP tools on the same port from a single Go binary, with no Google API key required.

## Features

- **OpenAI-Compatible API**: Exposes /v1/chat/completions, /v1/models and /v1/responses with true streaming, tool calls and Bearer authentication.
- **Native Gemini API and MCP**: Serves /v1beta/models/{model}:generateContent and MCP tools on the same port, so Google SDKs and gateway Google providers connect directly.
- **Models and Media Generation**: Covers Gemini 3.6 Flash, 3.5 Flash-Lite, 3.1 Pro, 3.8 Flash and 4 Argon, plus image, music, canvas and video generation through /v1/videos.
- **Cookie and Proxy Pools**: Rotates multiple Google accounts least-recently-used first with automatic renewal, and schedules a proxy pool with runtime edits and circuit breaking where every exit IP gets its own rate limit.
- **Built-in Admin Dashboard**: The admin panel covers overview, request records, proxy pool, cookie pool, runtime settings and API key rotation, applied immediately on save.
- **Single Binary and Multiple Databases**: One Go binary on a distroless base image, with persistence through SQLite, MySQL or PostgreSQL; prompts and responses are never stored.
