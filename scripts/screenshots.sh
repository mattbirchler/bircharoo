#!/usr/bin/env bash
# Capture the kitchen-sink test note in every combination the theme has to
# hold: light and dark, reading and editing, desktop and a phone-width window.
# Drop the folder into a diff tool against an earlier run to see what moved.
#
# Usage: scripts/screenshots.sh [out-dir] [vault-path]
#   out-dir     where the PNGs go (default: screenshots/)
#   vault-path  vault to capture in (default: ~/Obsidian/Birchler-alt, the dev vault)
#
# Needs Obsidian running with the Obsidian CLI available. Installs the theme
# first, copies test/Bircharoo Test.md (and an image it embeds) to the vault
# root, and puts the theme mode, the open note, and the sidebars back the way
# they were when it's done.
set -euo pipefail
OUT="${1:-screenshots}"
VAULT_PATH="${2:-$HOME/Obsidian/Birchler-alt}"
VAULT_NAME="$(basename "$VAULT_PATH")"
DIR="$(cd "$(dirname "$0")/.." && pwd)"
NOTE="Bircharoo Test.md"
NARROW_WIDTH=430
NARROW_HEIGHT=932
MAX_PAGES=6

ob() { obsidian vault="$VAULT_NAME" "$@"; }
ev() { ob eval code="$1" | sed 's/^=> //'; }
cdp() { ob dev:cdp method="$1" params="$2" >/dev/null; }
shot() {
  ob dev:cdp method=Page.captureScreenshot params='{"format":"png"}' \
    | python3 -c 'import sys,json,base64;sys.stdout.buffer.write(base64.b64decode(json.load(sys.stdin)["data"]))' \
    > "$1"
  echo "  $1"
}
set_mode() {  # light | dark
  local t=obsidian; [ "$1" = light ] && t=moonstone
  ev "app.changeTheme('$t')" >/dev/null
}
set_view() {  # reading | editing
  local m=source; [ "$1" = reading ] && m=preview
  ev "(function(){var l=app.workspace.getMostRecentLeaf();var s=l.getViewState();s.state.mode='$m';s.state.source=false;return l.setViewState(s);})()" >/dev/null
}

if ! command -v obsidian >/dev/null 2>&1; then
  echo "The Obsidian CLI is not on PATH." >&2; exit 1
fi

"$DIR/scripts/install.sh" "$VAULT_PATH" >/dev/null
cp "$DIR/test/$NOTE" "$VAULT_PATH/$NOTE"
cp "$DIR/screenshot.png" "$VAULT_PATH/Bircharoo Test.png"
mkdir -p "$OUT"

prev_theme="$(ev "app.vault.getConfig('theme')")"
prev_file="$(ev "app.workspace.getActiveFile()?.path ?? ''")"
prev_left="$(ev "app.workspace.leftSplit.collapsed")"
prev_right="$(ev "app.workspace.rightSplit.collapsed")"
restore() {
  cdp Emulation.clearDeviceMetricsOverride '{}'
  ev "app.changeTheme('$prev_theme')" >/dev/null
  [ "$prev_left" = true ] && ev "app.workspace.leftSplit.collapse()" >/dev/null
  [ "$prev_right" = false ] && ev "app.workspace.rightSplit.expand()" >/dev/null
  [ -n "$prev_file" ] && ob open path="$prev_file" >/dev/null
}
trap restore EXIT

ob open path="$NOTE" >/dev/null
ev "app.workspace.leftSplit.expand(); app.workspace.rightSplit.collapse()" >/dev/null
sleep 1

# Scroll the note one viewport at a time so the whole test note is covered.
scroller() { [ "$1" = reading ] && echo ".workspace-leaf.mod-active .markdown-preview-view" || echo ".workspace-leaf.mod-active .cm-scroller"; }
page_count() {
  # The view can take a moment to lay out after a mode switch; wait for it.
  local n=NaN i
  for i in 1 2 3 4 5 6 7 8 9 10; do
    n="$(ev "(function(){var s=document.querySelector('$(scroller "$1")');if(!s||!s.clientHeight)return NaN;return Math.min($MAX_PAGES,Math.ceil(s.scrollHeight/s.clientHeight));})()")"
    case "$n" in ''|*[!0-9]*) sleep 0.3 ;; *) break ;; esac
  done
  case "$n" in ''|*[!0-9]*) echo 1 ;; *) echo "$n" ;; esac
}
scroll_to_page() { ev "(function(){var s=document.querySelector('$(scroller "$1")');s.scrollTop=s.clientHeight*$2;})()" >/dev/null; }

echo "Desktop"
for mode in light dark; do
  set_mode "$mode"; sleep 0.6
  for view in reading editing; do
    set_view "$view"; sleep 1.2
    n="$(page_count "$view")"
    for ((p=0; p<n; p++)); do
      scroll_to_page "$view" "$p"; sleep 0.4
      shot "$OUT/$mode-$view-$((p+1)).png"
    done
  done
done

echo "Phone width (${NARROW_WIDTH}px)"
cdp Emulation.setDeviceMetricsOverride "{\"width\":$NARROW_WIDTH,\"height\":$NARROW_HEIGHT,\"deviceScaleFactor\":2,\"mobile\":false}"
ev "app.workspace.leftSplit.collapse()" >/dev/null
sleep 0.5
for mode in light dark; do
  set_mode "$mode"
  set_view reading; sleep 0.8
  scroll_to_page reading 0
  shot "$OUT/$mode-narrow.png"
done
