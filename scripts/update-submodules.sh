#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Updating all submodules from upstream (origin)..."
echo ""

cd "$ROOT_DIR"

git submodule sync --recursive >/dev/null 2>&1
git submodule update --init --recursive >/dev/null 2>&1

git submodule foreach --recursive '
  echo "Updating: $name"

  # Ensure we have latest remote refs
  git fetch origin --prune >/dev/null 2>&1

  # Determine default branch (main/master/etc.)
  branch=$(git remote show origin 2>/dev/null | sed -n "s/.*HEAD branch: //p")

  if [ -z "$branch" ]; then
    branch="main"
  fi

  echo "Tracking branch: $branch"

  # Checkout branch (or create local tracking branch if missing)
  git checkout "$branch" >/dev/null 2>&1 || git checkout -b "$branch" "origin/$branch" >/dev/null 2>&1

  # Pull latest changes from upstream
  git pull --ff-only origin "$branch" >/dev/null 2>&1

  echo "Updated: $name"
  echo ""
'

echo ""
echo "All submodules updated from upstream successfully."