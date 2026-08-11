#!/usr/bin/env bash

source ${PWD}/scripts/prints.sh

function link_starship_profiles() {
  local config_path="$HOME/.config/starship.toml"

  if [[ -L "$config_path" ]]; then
    unlink "$config_path"
  elif [[ -e "$config_path" ]]; then
    mv "$config_path" "$config_path.bak"
  fi

  if [[ ! -d "$HOME/.config" ]]; then
    mkdir -p "$HOME/.config"
  fi

  clprint "info" "ln -sf `realpath $PWD/assets/dotfiles/profiles/starship/starship.toml` $config_path"
  ln -sf `realpath $PWD/assets/dotfiles/profiles/starship/starship.toml` $config_path
}

function main() {
  link_starship_profiles
}

main
