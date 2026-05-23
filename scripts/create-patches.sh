#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

PATCHED_BRANCH="patched"
BASE_BRANCH="master"

SUBMODULES=(
  "gitrss"
  "package-json-analyzer"
  "openapi-merger"
)

echo "Creating patches for all submodules..."
echo "Patched branch: $PATCHED_BRANCH"
echo "Base branch: $BASE_BRANCH"

for module in "${SUBMODULES[@]}"; do

  echo ""
  echo "Processing: $module"

  MODULE_DIR="$ROOT_DIR/$module"
  PATCH_DIR="$ROOT_DIR/patches/$module"

  mkdir -p "$PATCH_DIR"

  cd "$MODULE_DIR"

  echo "Fetching origin..."
  git fetch origin >/dev/null

  echo "Checking out patched branch..."
  git checkout "$PATCHED_BRANCH" >/dev/null 2>&1

  echo "Cleaning old patches..."
  rm -f "$PATCH_DIR"/*.patch

  echo "Creating patch files..."

  git format-patch "origin/$BASE_BRANCH" \
    --output-directory "$PATCH_DIR" >/dev/null

  PATCH_COUNT=$(find "$PATCH_DIR" -name "*.patch" | wc -l)

  if [ "$PATCH_COUNT" -eq 0 ]; then
    echo "No local commits found."
    continue
  fi

  echo "Created $PATCH_COUNT patch(es)."

done

echo ""
echo "Created all patches successfully"