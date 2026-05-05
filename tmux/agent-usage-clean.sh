#!/usr/bin/env sh
# Wrapper around agent-usage-status.sh that strips its trailing " ⡆ │ " separator,
# so tmux's status format can supply its own consistent separator instead.
~/.dotfiles/tmux/agent-usage-status.sh "$@" | sed -E 's/(#\[[^]]*\])? *⡆.*$//' | sed -E 's/[[:space:]]*#\[[^]]*\][[:space:]]*│[[:space:]]*$//'
