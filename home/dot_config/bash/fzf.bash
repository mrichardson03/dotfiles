#!/usr/bin/env bash
# fzf configuration and functions

if command -v fzf >/dev/null 2>&1; then
  # Locate file with fzf, open in editor
  vf() {
    local file
    file=$(fzf --preview "bat --color=always {} 2>/dev/null || cat {}") && ${EDITOR:-vim} "$file"
  }

  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --info=inline"

  if command -v fdfind >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --follow --exclude .git"
  fi
fi
