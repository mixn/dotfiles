###############################################################################
# Zsh                                                                         #
###############################################################################

export ZSH=/Users/mixn/.oh-my-zsh

# Load Antigen
. ~/.dotfiles/antigen/init.zsh

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
. ~/.dotfiles/extra.zsh
. ~/.dotfiles/functions.zsh
. ~/.dotfiles/git.zsh
. ~/.dotfiles/nvm/init.zsh
. ~/.dotfiles/serverless/init.zsh
. ~/.dotfiles/thefuck/init.zsh
. ~/.dotfiles/z/init.zsh