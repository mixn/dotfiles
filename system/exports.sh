# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
export HISTFILE=~/.zsh_history

# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear";

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';