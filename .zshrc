###############################################################################
# Zsh                                                                         #
###############################################################################
export ZSH=/Users/mixn/.oh-my-zsh

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

# Enable and reload completion
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# Initialize Pure prompt
autoload -U promptinit; promptinit
prompt pure

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



### GIT
GIT_AUTHOR_NAME="mixn"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="sutmil@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"



### EXPORTS
# Make vim the default editor.
export EDITOR='vim';

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

. ~/.dotfiles/functions.zsh
. ~/.dotfiles/aliases.zsh