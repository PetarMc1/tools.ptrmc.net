#!/usr/bin/env bash

set -uo pipefail

REPO="docker2.petarmc.com"
IMAGE="petarmc/tools"
TAG="${1:-dev}"

echo "Removing any old containers"
docker stop tools-test >/dev/null 2>&1
docker rm tools-test >/dev/null 2>&1

./scripts/build-docker.sh $TAG 


echo "Running the container"
docker run -d \
  --name tools-test \
  -p 80:80 \
  -e GITRSS_REDIS_URL=redis://redis:6379 \
  -e GITRSS_DEEP_REFRESH_DAYS=10 \
  -e GITRSS_ADMIN_PASSWORD=change-me \
  --restart unless-stopped \
  $REPO/$IMAGE:$TAG 