#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Updating all submodules from upstream (origin)..."
echo ""

SUBMODULES=(
    "gitrss"
    "package-json-analyzer"
    "openapi-merger"
)

cd "$ROOT_DIR"

for module in "${SUBMODULES[@]}"; do
  echo "Updating $module..."
  cd "$ROOT_DIR/$module"
  git fetch origin >/dev/null 2>&1
  git reset --hard origin/HEAD >/dev/null 2>&1
  git pull >/dev/null 2>&1
  echo ""
done

echo ""
echo "All submodules updated from upstream successfully."