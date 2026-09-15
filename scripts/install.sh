#!/usr/bin/env bash
# Copy the theme into a vault's themes folder and ask Obsidian to reload it.
# Usage: scripts/install.sh [vault-path]   (default: ~/Obsidian/Birchler)
# Obsidian does not follow symlinked theme folders, so files are copied.
set -euo pipefail
VAULT="${1:-$HOME/Obsidian/Birchler}"
SRC="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$VAULT/.obsidian/themes/Bircharoo"
mkdir -p "$DEST"
cp "$SRC/manifest.json" "$SRC/theme.css" "$DEST/"
if command -v obsidian >/dev/null 2>&1; then
  obsidian eval code="app.customCss.readThemes().then(()=>app.customCss.setTheme('Bircharoo')).then(()=>new Promise(r=>setTimeout(r,800))).then(()=>'reloaded')" >/dev/null 2>&1 || true
fi
echo "Installed to $DEST"
