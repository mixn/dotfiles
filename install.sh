#!/bin/sh

###############################################################################
# Install                                                                     #
###############################################################################

echo "Setting up Mac…"

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

# Make Zsh the default shell environment
chsh -s $(which zsh)

source .npm

# Install some globals via curl/wget
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

###############################################################################
# Symlinks                                                                    #
###############################################################################

source .symlinks

###############################################################################
# macOS                                                                    #
###############################################################################

# Set macOS preferences
# Run last because this will reload the shell
source .macos