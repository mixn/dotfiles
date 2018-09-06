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
source homebrew/install.sh
source node/install.sh
source nvm/install.sh
source composer/install.sh
source rust/install.sh
source oh-my-zsh/install.sh

###############################################################################
# Symlinks                                                                    #
###############################################################################

source .symlinks

###############################################################################
# macOS                                                                    #
###############################################################################

# Set macOS preferences
# Run last because this will reload the shell
source macos/.defaults