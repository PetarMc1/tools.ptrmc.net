#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

TARGET_BRANCH="patched"
BASE_BRANCH="master"

echo "Resetting all submodules..."

cd "$ROOT_DIR"

# Make sure submodules exist
git submodule sync --recursive >/dev/null 2>&1
git submodule update --init --recursive >/dev/null 2>&1

git submodule foreach --recursive "

  echo ''
  echo 'Processing: \$name'

  git fetch origin --prune >/dev/null 2>&1

  # ensure base branch exists locally
  git checkout '$BASE_BRANCH' >/dev/null 2>&1 || \
    git checkout -b '$BASE_BRANCH' 'origin/$BASE_BRANCH' >/dev/null 2>&1

  git reset --hard 'origin/$BASE_BRANCH' >/dev/null 2>&1
  git clean -fdx >/dev/null 2>&1

  # recreate patched branch from clean base
  git checkout -B '$TARGET_BRANCH' >/dev/null 2>&1

  echo 'Reset complete'
"

echo ""
echo "All submodules reset successfully"