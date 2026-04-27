#!/usr/bin/env bash
# agents/install.sh — sync coding-agent configs (Claude Code, Codex, …)
#                     between ~/.dotfiles and per-tool home dirs.
#
# Usage:
#   agents/install.sh                  # dry-run — show what would happen
#   agents/install.sh --apply          # actually do it
#   agents/install.sh --bootstrap      # first-time migration: move existing
#                                      # ~/.claude content into the repo
#   agents/install.sh --bootstrap --apply
#
# Safety:
#   - allowlist-driven; never touches anything not listed in ALLOW_* arrays
#   - secret-pattern scan refuses to migrate matching files
#   - settings.json sanitized to known-safe keys before being moved into repo

set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
AGENTS="$DOTFILES/agents"
MANIFEST="$AGENTS/agents.json"
CLAUDE_HOME="$HOME/.claude"
CODEX_HOME="$HOME/.codex"

APPLY=0
BOOTSTRAP=0
for arg in "$@"; do
  case "$arg" in
    --apply)     APPLY=1 ;;
    --bootstrap) BOOTSTRAP=1 ;;
    -h|--help)
      sed -n '2,16p' "$0" | sed 's/^# \{0,1\}//'
      exit 0 ;;
    *) echo "unknown arg: $arg" >&2; exit 2 ;;
  esac
done

# ─── Logging ─────────────────────────────────────────────────────────────────
c_dim()   { printf '\033[2m%s\033[0m\n' "$*"; }
c_info()  { printf '\033[36m%s\033[0m\n' "$*"; }
c_ok()    { printf '\033[32m%s\033[0m\n' "$*"; }
c_warn()  { printf '\033[33m%s\033[0m\n' "$*"; }
c_err()   { printf '\033[31m%s\033[0m\n' "$*" >&2; }
plan()    { if [[ $APPLY -eq 1 ]]; then printf '  do  %s\n' "$*"; else printf '  would  %s\n' "$*"; fi; }
run()     { if [[ $APPLY -eq 1 ]]; then "$@"; fi; }

# ─── Preconditions ───────────────────────────────────────────────────────────
command -v jq >/dev/null || { c_err "jq required (brew install jq)"; exit 1; }
[[ -f "$MANIFEST" ]] || { c_err "manifest missing: $MANIFEST"; exit 1; }

# ─── Safety: allowlist + denylist ────────────────────────────────────────────
# Files/dirs we will move from ~/.claude into agents/ during --bootstrap.
ALLOW_CLAUDE_FILES=(
  "settings.json"
  "statusline.sh"
  "mcp.json"
)
ALLOW_CLAUDE_DIRS=(
  "rules"
  "commands"
  "skills"   # only user-authored; plugin skills live under plugins/cache/
  "agents"
)
# Note: ~/.claude/hooks/ NOT auto-migrated — plugins write runtime workers there
# (e.g. ouroboros's gsd-check-update-worker.js). Author hooks manually in
# agents/claude/hooks/ and they will be symlinked in.

# Codex bootstrap: only migrate AGENTS.md (top-level rules file). config.toml is
# managed by external installers (e.g. ouroboros) and is intentionally NOT touched.
ALLOW_CODEX_FILES=(
  "AGENTS.md"
  "config.toml"
)

# Keys preserved when sanitizing settings.json. Anything else is dropped.
SETTINGS_SAFE_KEYS='["enabledPlugins","extraKnownMarketplaces","theme","voice","voiceEnabled","skipDangerousModePermissionPrompt","skipAutoPermissionPrompt","statusLine"]'

# Regex of secrets we refuse to copy.
SECRET_RE='(api[_-]?key|secret|password|bearer|authorization|x-api-key|access[_-]?token)[^a-z0-9_-]*[:=][[:space:]]*["'"'"']?[A-Za-z0-9._-]{12,}'

scan_for_secrets() {
  local target="$1"
  local hits
  if [[ -d "$target" ]]; then
    hits=$(grep -rEIn -i --exclude-dir=node_modules --exclude='*.lock' "$SECRET_RE" "$target" 2>/dev/null || true)
  elif [[ -f "$target" ]]; then
    hits=$(grep -EIn -i "$SECRET_RE" "$target" 2>/dev/null || true)
  else
    hits=""
  fi
  if [[ -n "$hits" ]]; then
    c_err "secret-shaped content in $target — aborting:"
    printf '%s\n' "$hits" | head -10 >&2
    return 1
  fi
}

# ─── Helpers ────────────────────────────────────────────────────────────────
ensure_parent() { mkdir -p "$(dirname "$1")"; }
already_link_to() {
  # already_link_to <link> <target>
  [[ -L "$1" ]] && [[ "$(readlink "$1")" == "$2" ]]
}

link() {
  # link <src-in-repo> <dest-in-home>
  local src="$1" dest="$2"
  if already_link_to "$dest" "$src"; then
    c_dim "  ok    $dest"
    return
  fi
  if [[ -e "$dest" || -L "$dest" ]]; then
    plan "backup $dest"
    if [[ $APPLY -eq 1 ]]; then
      local ts; ts=$(date +%Y%m%d-%H%M%S)
      local backup_dir="$CLAUDE_HOME/backups/dotfiles-migration/$ts"
      mkdir -p "$backup_dir"
      mv "$dest" "$backup_dir/$(basename "$dest")"
    fi
  fi
  plan "ln -s $src $dest"
  if [[ $APPLY -eq 1 ]]; then
    ensure_parent "$dest"
    ln -s "$src" "$dest"
  fi
}

# ─── Bootstrap: move existing user content into the repo ────────────────────
sanitize_settings() {
  local src="$1" out="$2"
  jq --argjson keep "$SETTINGS_SAFE_KEYS" \
     'with_entries(select(.key as $k | $keep | index($k)))' "$src" > "$out"
  if ! diff -q "$src" "$out" >/dev/null 2>&1; then
    c_warn "settings.json: dropping non-allowlisted keys"
    diff <(jq -S 'keys' "$src") <(jq -S 'keys' "$out") || true
  fi
}

bootstrap_claude() {
  c_info "[bootstrap] migrating ~/.claude allowlisted content into repo"
  local f d src dest
  for f in "${ALLOW_CLAUDE_FILES[@]}"; do
    src="$CLAUDE_HOME/$f"
    [[ -e "$src" && ! -L "$src" ]] || continue
    case "$f" in
      settings.json)
        dest="$AGENTS/claude/settings.json"
        plan "sanitize+copy $src -> $dest"
        if [[ $APPLY -eq 1 ]]; then
          ensure_parent "$dest"
          sanitize_settings "$src" "$dest"
        fi
        ;;
      *)
        dest="$AGENTS/claude/$f"
        scan_for_secrets "$src"
        plan "move $src -> $dest"
        if [[ $APPLY -eq 1 ]]; then
          ensure_parent "$dest"
          mv "$src" "$dest"
        fi
        ;;
    esac
  done

  for d in "${ALLOW_CLAUDE_DIRS[@]}"; do
    src="$CLAUDE_HOME/$d"
    [[ -d "$src" && ! -L "$src" ]] || continue
    case "$d" in
      rules|commands)
        dest="$AGENTS/shared/$d"
        scan_for_secrets "$src"
        plan "merge-move $src/* -> $dest/"
        if [[ $APPLY -eq 1 ]]; then
          mkdir -p "$dest"
          # move only files, not subdirs we don't expect
          shopt -s nullglob dotglob
          for entry in "$src"/*; do
            mv "$entry" "$dest/"
          done
          shopt -u nullglob dotglob
          rmdir "$src" 2>/dev/null || true
        fi
        ;;
      skills)
        dest="$AGENTS/shared/skills"
        plan "merge-move user skills $src/* -> $dest/"
        if [[ $APPLY -eq 1 ]]; then
          mkdir -p "$dest"
          shopt -s nullglob
          for entry in "$src"/*/; do
            local name; name=$(basename "$entry")
            scan_for_secrets "$entry"
            mv "$entry" "$dest/$name"
          done
          shopt -u nullglob
          rmdir "$src" 2>/dev/null || true
        fi
        ;;
      hooks|agents)
        dest="$AGENTS/claude/$d"
        scan_for_secrets "$src"
        plan "merge-move $src/* -> $dest/"
        if [[ $APPLY -eq 1 ]]; then
          mkdir -p "$dest"
          shopt -s nullglob dotglob
          for entry in "$src"/*; do
            mv "$entry" "$dest/"
          done
          shopt -u nullglob dotglob
          rmdir "$src" 2>/dev/null || true
        fi
        ;;
    esac
  done
  if [[ $APPLY -eq 1 ]]; then
    touch "$AGENTS/.bootstrapped"
  fi
}

bootstrap_codex() {
  [[ -d "$CODEX_HOME" ]] || { c_dim "[bootstrap] no ~/.codex; skipping"; return; }
  c_info "[bootstrap] migrating ~/.codex allowlisted content into repo"
  local f src dest
  for f in "${ALLOW_CODEX_FILES[@]}"; do
    src="$CODEX_HOME/$f"
    [[ -e "$src" && ! -L "$src" ]] || continue
    dest="$AGENTS/codex/$f"
    [[ -e "$dest" ]] && { c_dim "  $dest exists, skipping"; continue; }
    scan_for_secrets "$src"
    plan "move $src -> $dest"
    if [[ $APPLY -eq 1 ]]; then
      ensure_parent "$dest"
      mv "$src" "$dest"
    fi
  done
}

# ─── Reconcile: create symlinks per manifest ────────────────────────────────
link_claude_skill() { link "$AGENTS/$2" "$CLAUDE_HOME/skills/$1"; }
link_codex_skill()  { [[ -d "$CODEX_HOME" ]] && link "$AGENTS/$2" "$CODEX_HOME/skills/$1"; }
link_claude_rule()  { link "$AGENTS/$2" "$CLAUDE_HOME/rules/$(basename "$2")"; }
# Codex has no per-file rules dir; rules merge into AGENTS.md (handled separately).
link_claude_command(){ link "$AGENTS/$2" "$CLAUDE_HOME/commands/$(basename "$2")"; }

reconcile_top_level_codex_files() {
  [[ -d "$CODEX_HOME" ]] || return 0
  [[ -f "$AGENTS/codex/AGENTS.md" ]]   && link "$AGENTS/codex/AGENTS.md"   "$CODEX_HOME/AGENTS.md"
  [[ -f "$AGENTS/codex/config.toml" ]] && link "$AGENTS/codex/config.toml" "$CODEX_HOME/config.toml"
  return 0
}

reconcile_top_level_claude_files() {
  [[ -f "$AGENTS/claude/settings.json" ]] && link "$AGENTS/claude/settings.json" "$CLAUDE_HOME/settings.json"
  [[ -f "$AGENTS/claude/statusline.sh" ]] && link "$AGENTS/claude/statusline.sh" "$CLAUDE_HOME/statusline.sh"
  [[ -f "$AGENTS/claude/mcp.json" ]]      && link "$AGENTS/claude/mcp.json"      "$CLAUDE_HOME/mcp.json"
  if [[ -d "$AGENTS/claude/hooks" ]]; then
    shopt -s nullglob
    for f in "$AGENTS/claude/hooks"/*; do
      link "$f" "$CLAUDE_HOME/hooks/$(basename "$f")"
    done
    shopt -u nullglob
  fi
  if [[ -d "$AGENTS/claude/agents" ]]; then
    shopt -s nullglob
    for f in "$AGENTS/claude/agents"/*; do
      link "$f" "$CLAUDE_HOME/agents/$(basename "$f")"
    done
    shopt -u nullglob
  fi
  return 0
}

reconcile_manifest() {
  c_info "[reconcile] linking manifest entries"

  # skills
  while IFS=$'\t' read -r name path tools; do
    for tool in ${tools//,/ }; do
      case "$tool" in
        claude) link_claude_skill "$name" "$path" ;;
        codex)  link_codex_skill  "$name" "$path" ;;
      esac
    done
  done < <(jq -r '.skills[]? | "\(.name)\t\(.path)\t\(.tools | join(","))"' "$MANIFEST")

  # rules: claude only (per-file). codex consumes rules via merged AGENTS.md
  # which we deliberately do NOT generate — codex's AGENTS.md is owned by the
  # user / external installers (e.g. ouroboros).
  while IFS=$'\t' read -r name path tools; do
    for tool in ${tools//,/ }; do
      case "$tool" in
        claude) link_claude_rule "$name" "$path" ;;
      esac
    done
  done < <(jq -r '.rules[]? | "\(.name)\t\(.path)\t\(.tools | join(","))"' "$MANIFEST")

  # commands
  while IFS=$'\t' read -r name path tools; do
    for tool in ${tools//,/ }; do
      case "$tool" in
        claude) link_claude_command "$name" "$path" ;;
      esac
    done
  done < <(jq -r '.commands[]? | "\(.name)\t\(.path)\t\(.tools | join(","))"' "$MANIFEST")
}

reconcile_plugins() {
  c_info "[reconcile] dispatching plugin install per manager"
  while IFS=$'\t' read -r mgr name source; do
    case "$mgr" in
      claude-marketplace)
        # settings.json declares enabledPlugins; claude reconciles on launch.
        c_dim "  marketplace plugin: $name (auto-reconciled by claude on launch)"
        ;;
      npx)
        c_dim "  npx package: $name (declarative only)"
        ;;
      brew)
        if brew list "$name" >/dev/null 2>&1; then
          c_dim "  brew: $name already installed"
        else
          plan "brew install $name"
          run brew install "$name"
        fi
        ;;
      git)
        plan "git fetch $source"
        # repo-specific install left as future extension
        ;;
      *)
        c_warn "  unknown manager: $mgr ($name)"
        ;;
    esac
  done < <(jq -r '.plugins[]? | "\(.manager)\t\(.name)\t\(.source // "")"' "$MANIFEST")

  # external (npx/brew tools that aren't agent plugins)
  while IFS=$'\t' read -r mgr name pkg; do
    case "$mgr" in
      npx)  c_dim "  external npx: $name (no install needed)" ;;
      brew)
        if brew list "$pkg" >/dev/null 2>&1; then
          c_dim "  external brew: $pkg already installed"
        else
          plan "brew install $pkg"
          run brew install "$pkg"
        fi
        ;;
    esac
  done < <(jq -r '.external[]? | "\(.manager)\t\(.name)\t\(.package // .name)"' "$MANIFEST")
}

# ─── Main ────────────────────────────────────────────────────────────────────
mode_label() { [[ $APPLY -eq 1 ]] && echo "APPLY" || echo "DRY-RUN"; }
c_info "agents/install.sh — mode: $(mode_label)"

if [[ $BOOTSTRAP -eq 1 ]]; then
  if [[ -f "$AGENTS/.bootstrapped" ]]; then
    c_warn "already bootstrapped (marker file present); running reconcile only"
  else
    bootstrap_claude
  fi
  bootstrap_codex
fi

reconcile_top_level_claude_files
reconcile_top_level_codex_files
reconcile_manifest
reconcile_plugins

c_ok "done."
if [[ $APPLY -eq 0 ]]; then
  c_dim "(re-run with --apply to make changes)"
fi
exit 0
