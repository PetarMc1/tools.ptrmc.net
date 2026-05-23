#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

SUBMODULES=(
  "gitrss"
  "package-json-analyzer"
  "openapi-merger"
)

install_if_exists() {
  local dir="$1"

  if [ -d "$dir" ]; then
    echo "Installing dependencies in: $dir"

    pnpm install \
      --dir "$dir" \
      --reporter=silent \
      --config.confirmModulesPurge=false \
      >/dev/null

    echo "Finished: $dir"
    echo ""
  fi
}

echo "Installing dependencies for root frontend"
install_if_exists "$ROOT_DIR/frontend"

for module in "${SUBMODULES[@]}"; do

  echo "Processing module: $module"

  MODULE_DIR="$ROOT_DIR/$module"

  install_if_exists "$MODULE_DIR/frontend"
  install_if_exists "$MODULE_DIR/backend"

  if [ "$module" = "openapi-merger" ]; then
    install_if_exists "$MODULE_DIR/shared"
  fi

done

echo "All dependencies installed successfully"