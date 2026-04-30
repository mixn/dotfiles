#!/bin/sh

###############################################################################
# Install                                                                     #
###############################################################################

echo "Setting up Mac…"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.install` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

###############################################################################
# Dependencies                                                                #
###############################################################################

# Install all the things
source ~/.dotfiles/homebrew/install.sh
source ~/.dotfiles/nvm/install.sh
source ~/.dotfiles/oh-my-zsh/install.sh
source ~/.dotfiles/node/install.sh
source ~/.dotfiles/tpm/install.sh
source ~/.dotfiles/tmux/install.sh
source ~/.dotfiles/composer/install.sh
source ~/.dotfiles/rust/install.sh

###############################################################################
# Symlinks                                                                    #
###############################################################################

source ~/.dotfiles/system/.symlinks

###############################################################################
# Agent tooling (Claude Code, Codex, …)                                       #
###############################################################################

# Idempotent. Bootstrap on first run, just reconcile thereafter.
if [ ! -f ~/.dotfiles/agents/.bootstrapped ]; then
  ~/.dotfiles/agents/install.sh --bootstrap --apply
else
  ~/.dotfiles/agents/install.sh --apply
fi

# Pre-commit hook for the dotfiles repo (denies secrets/runtime paths)
if [ -d ~/.dotfiles/.git/hooks ] && [ ! -L ~/.dotfiles/.git/hooks/pre-commit ]; then
  ln -sf ~/.dotfiles/agents/pre-commit-hook.sh ~/.dotfiles/.git/hooks/pre-commit
fi

###############################################################################
# macOS                                                                    #
###############################################################################

# Set macOS preferences
# Run last because this will reload the shell
source ~/.dotfiles/macos/.defaults
