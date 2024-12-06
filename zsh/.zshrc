export ZSH=/Users/mixn/.oh-my-zsh

# Load Antigen
source ~/.antigen.zsh
. ~/.dotfiles/antigen/init.zsh

# Case sensitive matches only
CASE_SENSITIVE="true"

# Reload
source $ZSH/oh-my-zsh.sh

# Initialize Pure prompt
autoload -U promptinit
promptinit
prompt pure

# Source and load all things used manually,
# I prefer the explicitness here over a loop
. ~/.dotfiles/vim/init.zsh
. ~/.dotfiles/node/init.zsh
. ~/.dotfiles/system/init.zsh
. ~/.dotfiles/git/init.zsh
. ~/.dotfiles/nvm/init.zsh
. ~/.dotfiles/pnpm/init.zsh
. ~/.dotfiles/bun/init.zsh
. ~/.dotfiles/serverless/init.zsh
. ~/.dotfiles/thefuck/init.zsh
. ~/.dotfiles/z/init.zsh
. ~/.dotfiles/qfc/init.zsh
. ~/.dotfiles/editorconfig/init.zsh
. ~/.dotfiles/rust/init.zsh
. ~/.dotfiles/composer/init.zsh
. ~/.dotfiles/python/init.zsh

# Created by `pipx` on 2024-11-20 15:41:54
export PATH="$PATH:/Users/mixn/.local/bin"
