#!/usr/bin/env bash
# agents/pre-commit-hook.sh — refuses to commit anything matching secret patterns
#                              or runtime-state paths.
#
# Install:  ln -s ~/.dotfiles/agents/pre-commit-hook.sh ~/.dotfiles/.git/hooks/pre-commit

set -euo pipefail

SECRET_RE='(api[_-]?key|secret|password|bearer|authorization|x-api-key|access[_-]?token)[^a-z0-9_-]*[:=][[:space:]]*["'"'"']?[A-Za-z0-9._-]{12,}'
PATH_DENY_RE='(^|/)(sessions|projects|paste-cache|file-history|telemetry|tasks|shell-snapshots|session-env|history\.jsonl|backups|cache|plans|downloads)(/|$)'

# Block by path
bad_paths=$(git diff --cached --name-only | grep -E "$PATH_DENY_RE" || true)
if [[ -n "$bad_paths" ]]; then
  echo "✗ refusing to commit runtime/state paths:" >&2
  echo "$bad_paths" >&2
  exit 1
fi

# Block by content
hits=$(git diff --cached -U0 | grep -EIn -i "$SECRET_RE" || true)
if [[ -n "$hits" ]]; then
  echo "✗ refusing to commit secret-shaped content:" >&2
  echo "$hits" | head -20 >&2
  exit 1
fi

exit 0
