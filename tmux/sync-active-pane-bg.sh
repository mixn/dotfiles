#!/usr/bin/env bash
# Read ghostty's resolved bg, darken it by SHIFT_BY per RGB channel, write to
# tmux_conf_theme_focused_pane_bg in .tmux.conf.local, reload tmux if running.
# Keeps the active pane a touch darker than every other pane, same hue.
set -euo pipefail

GHOSTTY=${GHOSTTY:-/Applications/Ghostty.app/Contents/MacOS/ghostty}
TMUX=${TMUX_BIN:-/opt/homebrew/bin/tmux}
CONF="$HOME/.dotfiles/tmux/.tmux.conf.local"
LOG="$HOME/.dotfiles/tmux/sync-active-pane-bg.log"

log() { printf "[%s] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >> "$LOG"; }

bg=$("$GHOSTTY" +show-config 2>&1 | awk -F'= ' '/^background = /{print $2; exit}' | tr -d '#')
if [ -z "$bg" ] || [ ${#bg} -ne 6 ]; then
  log "could not parse ghostty bg: '$bg'"
  exit 1
fi

r=$((16#${bg:0:2}))
g=$((16#${bg:2:2}))
b=$((16#${bg:4:2}))
# how much darker the active pane sits, as a percentage; raise for more contrast.
# Scaling all three channels preserves the hue, so a tinted bg (Rose Pine's
# #191724) stays tinted instead of drifting toward neutral gray.
DARKEN_PCT=${DARKEN_PCT:-18}
keep=$(( 100 - DARKEN_PCT ))
nr=$(( r * keep / 100 ))
ng=$(( g * keep / 100 ))
nb=$(( b * keep / 100 ))
new=$(printf "#%02x%02x%02x" "$nr" "$ng" "$nb")

# replace any current value (hex, colourN, or default)
sed -i.bak -E "s|^tmux_conf_theme_focused_pane_bg=.*|tmux_conf_theme_focused_pane_bg=\"$new\"|" "$CONF"
rm -f "$CONF.bak"

if pgrep -x tmux >/dev/null 2>&1; then
  "$TMUX" source-file "$HOME/.tmux.conf" >/dev/null 2>&1 || true
  "$TMUX" refresh-client -S >/dev/null 2>&1 || true
fi

log "ghostty bg=#$bg -> focused-pane bg=$new"
