#!/usr/bin/env sh
# Prints battery percentage colored by level (green/yellow/red).
# Output is a tmux-format string with embedded #[fg=...] tags.

case "$(uname -s)" in
  Darwin)
    pct=$(pmset -g batt 2>/dev/null | grep -Eo '[0-9]+%' | head -1 | tr -d '%')
    ;;
  Linux)
    if [ -r /sys/class/power_supply/BAT0/capacity ]; then
      pct=$(cat /sys/class/power_supply/BAT0/capacity)
    elif [ -r /sys/class/power_supply/BAT1/capacity ]; then
      pct=$(cat /sys/class/power_supply/BAT1/capacity)
    fi
    ;;
esac

[ -z "$pct" ] && exit 0

if [ "$pct" -lt 20 ]; then
  color="#eb6f92"   # Rosé Pine love (red)
elif [ "$pct" -lt 50 ]; then
  color="#f6c177"   # Rosé Pine gold (yellow)
else
  color="#a6e3a1"   # soft green (Catppuccin-ish, pairs with Rosé Pine)
fi

printf '#[fg=%s]%s%%#[default]' "$color" "$pct"
