#!/usr/bin/bash

set -euo pipefail

function create_config_symlink() {
  if [[ -d "$XDG_CONFIG_HOME/$1" ]]; then
    rm -rf -i "${XDG_CONFIG_HOME:?}/$1"
  fi
  ln -sf "$DOTFILES/$1" "$XDG_CONFIG_HOME"
}

# Directory for dotfiles checkout.
export DOTFILES="$HOME/.dotfiles"

export XDG_CONFIG_HOME="$HOME/.config"

create_config_symlink kitty
create_config_symlink nvim
create_config_symlink resticprofile
