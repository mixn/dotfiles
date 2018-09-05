#!/bin/sh

###############################################################################
# Install                                                                     #
###############################################################################

echo "Setting up Mac…"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.install` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew and install if needed
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

###############################################################################
# Dependencies                                                                #
###############################################################################

# Update Homebrew recipes
brew update

# Install all dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Install node dependencies
source .npm

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install Rust
curl https://sh.rustup.rs -sSf | sh

###############################################################################
# macOS                                                                    #
###############################################################################

# Set macOS preferences
# Run last because this will reload the shell
source .macos

###############################################################################
# oh-my-zsh                                                                   #
###############################################################################

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Make Zsh the default shell environment
chsh -s $(which zsh)

###############################################################################
# Symlinks                                                                    #
###############################################################################

source .symlinks