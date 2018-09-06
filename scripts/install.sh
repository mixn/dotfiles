#!/bin/sh

###############################################################################
# Install                                                                     #
###############################################################################

echo "Setting up Mac…"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.install` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Dependencies                                                                #
###############################################################################

# Install all the things
source ~/.dotfiles/homebrew/install.sh
source ~/.dotfiles/node/install.sh
source ~/.dotfiles/nvm/install.sh
source ~/.dotfiles/composer/install.sh
source ~/.dotfiles/rust/install.sh
source ~/.dotfiles/oh-my-zsh/install.sh

###############################################################################
# Symlinks                                                                    #
###############################################################################

source ~/.dotfiles/system/.symlinks

###############################################################################
# macOS                                                                    #
###############################################################################

# Set macOS preferences
# Run last because this will reload the shell
source ~/.dotfiles/macos/.defaults