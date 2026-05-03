#!/bin/sh
# Wrapper for tmux status bar: strip agent-usage's trailing `│` divider
# (and its color tag + surrounding spaces) so it slots cleanly into our layout.
# Usage in tmux.conf: #(/path/to/agent-usage-status.sh claude)

set -e
agent-usage "$@" --tmux | sed 's/ *#\[[^]]*\]│ *$//'
