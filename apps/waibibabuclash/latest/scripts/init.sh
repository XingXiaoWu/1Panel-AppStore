#!/bin/bash
set -eu

# Generated from official installation evidence:
# - User-supplied deployment README: docker load installation step.
# - Bundled image manifest/config: linux/arm64, image reference and expected image ID.
# No upstream repository URL was supplied; the provided deployment bundle is the source.

case "$(uname -m)" in
    aarch64|arm64) ;;
    *) echo 'WaibibabuClash requires a Linux ARM64 host.' >&2; exit 1 ;;
esac

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
APP_DIR="$(dirname -- "$SCRIPT_DIR")"
IMAGE_ARCHIVE="$APP_DIR/waibibabuclash-server-linux-arm64.tar.gz"
IMAGE_REF='waibibabuclash-server:linux-arm64'
EXPECTED_IMAGE_ID='sha256:076593f39afc35cb71b5cee4666cc5022e2b6fd1c7ca1f832a82fd42b6e48a9d'

CURRENT_IMAGE_ID="$(docker image inspect --format '{{.Id}}' "$IMAGE_REF" 2>/dev/null || true)"
if [ "$CURRENT_IMAGE_ID" != "$EXPECTED_IMAGE_ID" ]; then
    if [ ! -f "$IMAGE_ARCHIVE" ]; then
        echo "Missing bundled Docker image: $IMAGE_ARCHIVE" >&2
        exit 1
    fi
    docker load -i "$IMAGE_ARCHIVE"
fi

ACTUAL_IMAGE_ID="$(docker image inspect --format '{{.Id}}' "$IMAGE_REF")"
if [ "$ACTUAL_IMAGE_ID" != "$EXPECTED_IMAGE_ID" ]; then
    echo 'The local Docker image does not match the bundled ARM64 image.' >&2
    exit 1
fi
