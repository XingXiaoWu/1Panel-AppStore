#!/bin/bash

# Generated from official installation evidence:
# - https://github.com/nelvko/clash-for-linux-install/blob/master/install.sh
# - https://github.com/nelvko/clash-for-linux-install/blob/master/resources/mixin.yaml
# - https://github.com/nelvko/clash-for-linux-install/blob/feat-docker/docker-compose.yaml

set -eu

mkdir -p data/providers

cat > data/config.yaml <<EOF
mixed-port: 7890
bind-address: "*"
allow-lan: true
authentication:
  - "${PROXY_USERNAME}:${PROXY_PASSWORD}"

mode: rule
log-level: info
ipv6: false

external-controller: "0.0.0.0:9090"
secret: "${CLASH_SECRET}"

proxy-providers:
  subscription:
    type: http
    url: "${CLASH_CONFIG_URL}"
    path: ./providers/subscription.yaml
    interval: 3600
    health-check:
      enable: true
      url: http://www.gstatic.com/generate_204
      interval: 300

proxy-groups:
  - name: AUTO
    type: url-test
    use:
      - subscription
    url: http://www.gstatic.com/generate_204
    interval: 300
  - name: PROXY
    type: select
    proxies:
      - AUTO
      - DIRECT
    use:
      - subscription

rules:
  - MATCH,PROXY

tun:
  enable: ${TUN_ENABLE}
  stack: system
  auto-route: true
  auto-redir: true
  auto-redirect: true
  auto-detect-interface: true
  dns-hijack:
    - any:53
    - tcp://any:53
  strict-route: true
  exclude-interface:
    - docker0
    - podman0

dns:
  enable: true
  listen: 0.0.0.0:1053
  enhanced-mode: fake-ip
  nameserver:
    - 114.114.114.114
    - 8.8.8.8
EOF

chmod 600 data/config.yaml
