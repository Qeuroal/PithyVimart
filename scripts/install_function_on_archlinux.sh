#!/usr/bin/env bash

function install_software_on_archlinux() {
  if [[ "$(has_sudo)" == "0" ]]; then
    clprint "warning" "You are not the root user."
    return
  fi

  asroot pacman -S --noconfirm ctags automake gcc cmake python3 python2 ack git fontconfig ripgrep fzf
  # node.js
  asroot pacman -S --noconfirm npm
  # snack.nvim 依赖: fd-find
  asroot pacman -S fd
}

# {{{> 在archlinux安装vimart
function install_vimart_on_archlinux() {
  backup_vim_data
  install_software_on_archlinux
  install_fonts_on_linux
  print_logo
}
# <}}}
