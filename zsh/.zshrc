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
. ~/.dotfiles/vim/init.zsh
. ~/.dotfiles/node/init.zsh
. ~/.dotfiles/python/init.zsh
. ~/.dotfiles/system/init.zsh
. ~/.dotfiles/git/init.zsh
. ~/.dotfiles/nvm/init.zsh
. ~/.dotfiles/serverless/init.zsh
. ~/.dotfiles/thefuck/init.zsh
. ~/.dotfiles/z/init.zsh
. ~/.dotfiles/qfc/init.zsh
. ~/.dotfiles/editorconfig/init.zsh
