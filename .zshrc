###############################################################################
# Zsh                                                                         #
###############################################################################

export ZSH=/Users/mixn/.oh-my-zsh

# Load Antigen
. ~/.dotfiles/antigen.zsh

# Case sensitive matches only
CASE_SENSITIVE="true"

# Reload
source $ZSH/oh-my-zsh.sh

# Initialize Pure prompt
autoload -U promptinit; promptinit
prompt pure

# Source and load all things used manually,
# I prefer the explicitness here over a loop
. ~/.dotfiles/aliases.zsh
. ~/.dotfiles/exports.zsh
. ~/.dotfiles/functions.zsh
. ~/.dotfiles/git.zsh
. ~/.dotfiles/nvm.zsh
. ~/.dotfiles/serverless.zsh
. ~/.dotfiles/thefuck.zsh
. ~/.dotfiles/z.zsh