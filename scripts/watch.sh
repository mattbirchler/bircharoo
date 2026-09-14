#!/usr/bin/env bash
# Re-run install.sh whenever theme.css or manifest.json changes.
# Usage: scripts/watch.sh [vault-path]
set -euo pipefail
DIR="$(cd "$(dirname "$0")/.." && pwd)"
last=""
while true; do
  now="$(stat -f '%m' "$DIR/theme.css" "$DIR/manifest.json" | tr '\n' ' ')"
  if [ "$now" != "$last" ]; then
    "$DIR/scripts/install.sh" "$@"
    last="$now"
  fi
  sleep 1
done
