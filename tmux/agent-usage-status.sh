#!/bin/sh
# Wrapper for tmux status bar: strip agent-usage's trailing `│` divider
# (and its color tag + surrounding spaces) so it slots cleanly into our layout.
# Usage in tmux.conf: #(/path/to/agent-usage-status.sh claude)

if command -v agent-usage >/dev/null 2>&1; then
    AGENT_USAGE=agent-usage
elif [ -x /home/linuxbrew/.linuxbrew/bin/agent-usage ]; then
    AGENT_USAGE=/home/linuxbrew/.linuxbrew/bin/agent-usage
elif [ -x /opt/homebrew/bin/agent-usage ]; then
    AGENT_USAGE=/opt/homebrew/bin/agent-usage
else
    exit 0
fi

"$AGENT_USAGE" "$@" --tmux | sed 's/ *#\[[^]]*\]│ *$//'
