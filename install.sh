#!/bin/sh

###############################################################################
# Install                                                                     #
###############################################################################

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

# Install global NPM packages
npm i -g now yarn gtop spot n pure-prompt serverless @vue/cli ember-cli nba-go git-open speed-test fkill-cli is-up-cli pkg

# Install some globals via curl/wget
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

###############################################################################
# Symlinks                                                                    #
###############################################################################

# Remove .zshrc from $HOME (if it exists) and symlink the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Remove .tmux.conf from $HOME (if it exists) and symlink the .tmux.conf file from the .dotfiles
rm -rf $HOME/.tmux.conf
ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf

# Remove .tmux.conf.local from $HOME (if it exists) and symlink the .tmux.conf.local file from the .dotfiles
rm -rf $HOME/.tmux.conf.local
ln -s $HOME/.dotfiles/.tmux.conf.local $HOME/.tmux.conf.local

# Remove aliases.sh from $HOME (if it exists) and symlink the aliases.sh file from the .dotfiles
rm -rf $HOME/.oh-my-zsh/lib/aliases.zsh
ln -s $HOME/.dotfiles/aliases.zsh $HOME/.oh-my-zsh/lib/aliases.zsh

# Remove .hyper.js from $HOME (if it exists) and copy the .hyper.js file from the .dotfiles,
# because as of this writing, the .hyper.js config can’t be symlinked ¯\_(ツ)_/¯
# Quite annoying, but… oh well
rm -rf $HOME/.hyper.js
cp $HOME/.dotfiles/.hyper.js $HOME/.hyper.js

# Set macOS preferences
# Run last because this will reload the shell
source .macos