#!/usr/bin/env bash

set -euo pipefail

ZSH_PLUGINS_DIR="$HOME/.zsh/plugins"
mkdir -p "$ZSH_PLUGINS_DIR"

# zsh-syntax-highlighting
if [[ -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]]; then
  rm -rf "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting"
fi
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting"

if [[ -d "$ZSH_PLUGINS_DIR/zsh-autosuggestions" ]]; then
  rm -rf "$ZSH_PLUGINS_DIR/zsh-autosuggestions"
fi
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGINS_DIR/zsh-autosuggestions"

