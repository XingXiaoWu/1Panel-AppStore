#!/bin/bash

# Generated from official installation evidence:
# - https://github.com/zexadev/gemini-web2api-go/blob/main/Dockerfile
# - https://github.com/zexadev/gemini-web2api-go/blob/main/docker-compose.yml

# Adjust host-mounted data directory permissions for the container runtime user.
if [ -d data ]; then
    chown -R 65532:65532 data
    chmod -R 755 data
fi
