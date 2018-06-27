###############################################################################
# Zsh                                                                         #
###############################################################################

export ZSH=/Users/mixn/.oh-my-zsh

# Boot Antigen
. ~/.dotfiles/antigen.zsh

# Disable themes since I’m using zsh Pure prompt at the bottom
ZSH_THEME=""

# Case sensitive matches only
CASE_SENSITIVE="true"

# Installed plugins
plugins=(
  git
  npm
  git-extras
	zsh-completions
)

# Enable and reload zsh-completions
autoload -U compinit && compinit

# Reload
source $ZSH/oh-my-zsh.sh

# Initialize Pure prompt
autoload -U promptinit; promptinit
prompt pure

# Source and load all things used manually,
# I prefer the explicitness here over a loop
. ~/.dotfiles/aliases.zsh
. ~/.dotfiles/functions.zsh
. ~/.dotfiles/git.zsh
. ~/.dotfiles/nvm.zsh
. ~/.dotfiles/exports.zsh
. ~/.dotfiles/serverless.zsh
. ~/.dotfiles/thefuck.zsh