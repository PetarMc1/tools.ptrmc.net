#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE="petarmc/tools"
TAG="${1:-dev}"
PUBLISH="${2:-}"

./scripts/apply-patches.sh >/dev/null

echo "Building image: $IMAGE:$TAG"

docker build -t "$IMAGE:$TAG" "$ROOT_DIR"

if [[ "$PUBLISH" == "--publish" || "$PUBLISH" == "-p" ]]; then
    echo "Publishing image..."

    docker push "$IMAGE:$TAG"

    echo "Published: $IMAGE:$TAG"
fi