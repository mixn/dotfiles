#!/bin/sh

echo "Setting up Mac…"

# Check for Homebrew and install if needed
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Make Zsh the default shell environment
chsh -s $(which zsh)

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install global NPM packages
npm i -g now yarn gtop spot n pure-prompt

# Install some globals via curl/wget
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# Remove .zshrc from $HOME (if it exists) and symlink the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Remove .hyper.js from $HOME (if it exists) and copy the .hyper.js file from the .dotfiles,
# because as of this writing, the .hyper.js config can’t be symlinked ¯\_(ツ)_/¯
rm -rf $HOME/.hyper.js
cp $HOME/.dotfiles/.hyper.js $HOME/.hyper.js