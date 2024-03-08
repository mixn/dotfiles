#!/bin/sh

# Check for Homebrew and install if needed
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL http://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

(
  echo
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
) >>/Users/mixn/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Update Homebrew recipes
brew update

# Install all dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle
