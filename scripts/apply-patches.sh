#!/usr/bin/env bash


ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

SUBMODULES=(
    "gitrss"
    "package-json-analyzer"
    "openapi-merger"
)

echo "Applying patches for all submodules..."

for module in "${SUBMODULES[@]}"; do

  echo ""
  echo "Processing: $module"

  MODULE_DIR="$ROOT_DIR/$module"
  PATCH_DIR="$ROOT_DIR/patches/$module"

  cd "$MODULE_DIR"



  if [ -d ".git/rebase-apply" ] || [ -d ".git/rebase-merge" ]; then
    echo "Found interrupted git am/rebase state"
    echo "Aborting previous operation..."

    git am --abort >/dev/null 2>&1 || true
    git rebase --abort >/dev/null 2>&1 || true
  fi

  GIT_DIR=$(git rev-parse --git-dir)

  if [ -d "$GIT_DIR/rebase-apply" ] || [ -d "$GIT_DIR/rebase-merge" ]; then
    rm -rf "$GIT_DIR/rebase-apply"
    rm -rf "$GIT_DIR/rebase-merge"
  fi


  if ls "$PATCH_DIR"/*.patch >/dev/null; then

    echo "Applying patches..."

    PATCHES=($(find "$PATCH_DIR" -maxdepth 1 -name "*.patch" | sort))

    if git am -3 "${PATCHES[@]}" >/dev/null; then

      echo "Patches applied successfully."

    else

      echo ""
      echo "Patch apply failed in $module"
      echo ""

      echo "Aborting failed apply..."

      git am --abort >/dev/null || true

      exit 1
    fi
  else
    echo "No patches found."
  fi

done

echo ""
echo "All patches applied successfully"