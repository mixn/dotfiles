#!/bin/sh
# no-mistakes — https://github.com/kunchenguid/no-mistakes
#
# Local git gate: `git push no-mistakes` instead of `origin` spins up a
# disposable worktree, runs an AI validation pipeline (review → test → docs →
# lint), forwards the branch only once everything is green, and opens the PR.
#
# The upstream installer keeps the real binary in ~/.no-mistakes/bin and exposes
# it via ~/.local/bin/no-mistakes (already on PATH via system/exports.sh). It
# also installs the background daemon as a systemd user service (launchd on
# macOS), falling back to a detached process. `no-mistakes update` upgrades it.
#
# Per-repo setup stays manual — it rewrites git remotes, so it is not something
# a dotfiles run should do behind your back:
#   cd <repo> && no-mistakes init
#   cd <repo> && no-mistakes init --fork-url <your-fork-url>   # fork workflow
#
# Requires `gh` for GitHub PR creation and CI monitoring (see Brewfile).

set -e

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
NM_DIR="${NM_HOME:-$HOME/.no-mistakes}"
SRC="$DOTFILES/no-mistakes/config.yaml"
DEST="$NM_DIR/config.yaml"
INSTALL_URL="https://raw.githubusercontent.com/kunchenguid/no-mistakes/main/docs/install.sh"

# Official release binaries ship with the maintainer's self-hosted Umami host
# and website ID baked in. Off here for the installer; no-mistakes/init.zsh
# keeps it off for the CLI and for the daemon, which resolves login-shell env.
export NO_MISTAKES_TELEMETRY=0

if command -v no-mistakes >/dev/null 2>&1; then
  echo "no-mistakes already installed at $(command -v no-mistakes) — upgrade with 'no-mistakes update'"
else
  curl -fsSL "$INSTALL_URL" | sh
fi

# Global config lives in the repo; back up anything real that's already there.
mkdir -p "$NM_DIR"
if [ -e "$DEST" ] && [ ! -L "$DEST" ]; then
  mv "$DEST" "$DEST.pre-dotfiles.$(date +%Y%m%d-%H%M%S)"
  echo "backed up existing $DEST"
fi
ln -sfn "$SRC" "$DEST"
echo "linked $DEST -> $SRC"

# Restart so a daemon started before the symlink picks up this config.
if command -v no-mistakes >/dev/null 2>&1; then
  no-mistakes daemon restart >/dev/null 2>&1 ||
    echo "warn: 'no-mistakes daemon restart' failed — run it manually"
fi
