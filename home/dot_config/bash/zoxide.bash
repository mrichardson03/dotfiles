#!/usr/bin/env bash
# zoxide initialization and configuration

if command -v zoxide >/dev/null 2>&1; then
  # Provides `z <dir>` to jump and `zi` for an interactive (fzf) picker.
  eval "$(zoxide init bash)"
fi
