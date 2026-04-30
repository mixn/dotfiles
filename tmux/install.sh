#!/bin/sh
# tmux-file-picker — https://github.com/raine/tmux-file-picker
# fzf popup that pastes file paths into current tmux pane.
# Bindings live in tmux/.tmux.conf.local (prefix C-f / C-g / C-d).

set -e

DEST="$HOME/.local/bin/tmux-file-picker"
URL="https://raw.githubusercontent.com/raine/tmux-file-picker/main/tmux-file-picker"

mkdir -p "$HOME/.local/bin"

if [ -x "$DEST" ]; then
  echo "tmux-file-picker already installed at $DEST"
else
  curl -fsSL -o "$DEST" "$URL"
  chmod +x "$DEST"
  echo "tmux-file-picker installed to $DEST"
fi
