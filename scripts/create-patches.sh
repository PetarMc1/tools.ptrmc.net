#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

SUBMODULES=(
  "gitrss"
  "package-json-analyzer"
  "openapi-merger"
)

echo "Creating patches for all submodules..."

./scripts/apply-patches.sh >/dev/null

for module in "${SUBMODULES[@]}"; do

  echo ""
  echo "Processing: $module"

  MODULE_DIR="$ROOT_DIR/$module"
  PATCH_DIR="$ROOT_DIR/patches/$module"

  mkdir -p "$PATCH_DIR"

  cd "$MODULE_DIR"

  echo "Cleaning old patches..."
  rm -f "$PATCH_DIR"/*.patch

  echo "Fetching origin..."
  git fetch origin >/dev/null

  CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"

  echo "Current branch: $CURRENT_BRANCH"

  echo "Creating patch files..."

  # create patches for commits ahead of origin
  git format-patch "origin/$CURRENT_BRANCH" \
    --output-directory "$PATCH_DIR" >/dev/null

  PATCH_COUNT=$(find "$PATCH_DIR" -name "*.patch" | wc -l)

  if [ "$PATCH_COUNT" -eq 0 ]; then
    echo "No local commits found."
    continue
  fi

  echo "Created $PATCH_COUNT patch(es)."

  echo "Removing local commits..."

  # hard reset branch back to upstream
  git reset --hard "origin/$CURRENT_BRANCH" >/dev/null

  echo "Submodule reset clean."

done

echo ""
echo "Created all patches"