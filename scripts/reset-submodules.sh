#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Hard resetting all submodules to origin state..."

cd "$ROOT_DIR"

# Make sure submodules are initialized
git submodule sync --recursive >/dev/null 2>&1
git submodule update --init --recursive >/dev/null 2>&1

git submodule foreach --recursive '
  branch=$(git remote show origin 2>/dev/null | sed -n "s/.*HEAD branch: //p")
  if [ -z "$branch" ]; then
    branch="main"
  fi
  git fetch origin --prune
  git checkout "$branch" 2>/dev/null || git checkout -b "$branch" "origin/$branch"
  git reset --hard "origin/$branch"
  git clean -fdx
' >/dev/null 2>&1

echo "All submodules hard reset to origin."