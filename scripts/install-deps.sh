#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

SUBMODULES=(
  "gitrss"
  "package-json-analyzer"
  "openapi-merger"
)

echo "Installing dependencies for frontend"
pnpm install --dir frontend --reporter=silent --config.confirmModulesPurge=false > /dev/null
echo "Finished installing dependencies for frontend"
echo ""

for module in "${SUBMODULES[@]}"; do
    echo "Installing dependencies for $module..."

    MODULE_DIR="$ROOT_DIR/$module"

    cd "$MODULE_DIR"
    pnpm install --dir frontend > /dev/null
    pnpm install --dir backend > /dev/null

    if [$module == "openapi-merger"]; then
        pnpm install --dir shared > /dev/null
    fi

    echo "Finished installing dependencies for $module"
    echo ""
done