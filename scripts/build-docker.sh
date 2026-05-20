#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO="docker2.petarmc.com"
IMAGE="petarmc/tools"
TAG="${1:-dev}"
PUBLISH="${2:-}"

./scripts/apply-patches.sh >/dev/null

echo "Building image: $REPO/$IMAGE:$TAG"

docker build -t "$REPO/$IMAGE:$TAG" "$ROOT_DIR"

if [[ "$PUBLISH" == "--publish" || "$PUBLISH" == "-p" ]]; then
    echo "Publishing image..."

    docker push "$REPO/$IMAGE:$TAG"

    echo "Published: $REPO/$IMAGE:$TAG"
fi