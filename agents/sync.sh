#!/usr/bin/env bash
# agents/sync.sh — capture mutations from ~/.claude/settings.json into agents.json
#                  so other tools (Codex, etc.) can pick up newly-enabled plugins.
#
# Usage:
#   agents/sync.sh           # diff + propose
#   agents/sync.sh --apply   # write changes to agents.json

set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
AGENTS="$DOTFILES/agents"
MANIFEST="$AGENTS/agents.json"
SETTINGS="$HOME/.claude/settings.json"

APPLY=0
[[ "${1:-}" == "--apply" ]] && APPLY=1

command -v jq >/dev/null || { echo "jq required" >&2; exit 1; }

# Plugin names currently enabled in settings.json (form: "name@marketplace")
mapfile -t enabled < <(jq -r '.enabledPlugins | to_entries[] | select(.value == true) | .key' "$SETTINGS")

# Plugin names currently in manifest
mapfile -t known < <(jq -r '.plugins[]?.name' "$MANIFEST")

# Find new ones
new_plugins=()
for full in "${enabled[@]}"; do
  pname="${full%@*}"
  marketplace="${full#*@}"
  found=0
  for k in "${known[@]}"; do
    [[ "$k" == "$pname" ]] && { found=1; break; }
  done
  if [[ $found -eq 0 ]]; then
    new_plugins+=("$pname|$marketplace")
  fi
done

if [[ ${#new_plugins[@]} -eq 0 ]]; then
  echo "no new plugins to sync."
  exit 0
fi

echo "new plugins detected in settings.json:"
for entry in "${new_plugins[@]}"; do
  pname="${entry%|*}"; marketplace="${entry#*|}"
  echo "  + $pname (marketplace: $marketplace)"
done

if [[ $APPLY -eq 0 ]]; then
  echo
  echo "(dry-run; re-run with --apply to write to agents.json)"
  exit 0
fi

# Append entries (best-effort; user fills in source URL after)
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
jq_args=()
addition='[]'
for entry in "${new_plugins[@]}"; do
  pname="${entry%|*}"; marketplace="${entry#*|}"
  src=$(jq -r --arg m "$marketplace" '.extraKnownMarketplaces[$m].source | if .source == "github" then "github:" + .repo else "" end // ""' "$SETTINGS")
  addition=$(jq --arg n "$pname" --arg m "$marketplace" --arg s "$src" \
    '. + [{name:$n, manager:"claude-marketplace", source:$s, marketplace:$m, tools:["claude"]}]' \
    <<<"$addition")
done

jq --argjson add "$addition" '.plugins = (.plugins + $add)' "$MANIFEST" > "$tmp"
mv "$tmp" "$MANIFEST"
echo "agents.json updated. Review with: git -C $DOTFILES diff agents/agents.json"
