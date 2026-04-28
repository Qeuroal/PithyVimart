#!/usr/bin/env bash

source ${PWD}/scripts/prints.sh

# {{{> 获取ubuntu版本
function get_ubuntu_version() {
  line=$(cat /etc/lsb-release | grep "DISTRIB_RELEASE")
  arr=(${line//=/ })
  version=(${arr[1]//./ })

  echo ${version[0]}
}
# <}}}

# {{{> 安装ubuntu必备软件
function install_dependency_on_ubuntu() {
  if [[ "$(has_sudo)" == "0" ]]; then
    clprint "warning" "You are not the root user."
    return
  fi

  # echo -e "\033[32m==> Installing softwares...\033[0m"
  clprint "info" "Installing softwares..."
  asroot apt-get update

  version=$(get_ubuntu_version)
  if [ $version -eq 14 ];then
    asroot apt-get install -y cmake3
  else
    asroot apt-get install -y cmake
  fi

  asroot apt-get install -y build-essential fontconfig libfile-next-perl ack-grep git ripgrep fzf
  # asroot apt-get install -y python3-dev python python-dev
  asroot apt-get install -y python3 python3-dev python3-env
  asroot apt-get install -y universal-ctags || asroot apt-get install -y exuberant-ctags
  # node.js
  asroot apt-get install -y npm
  # snack.nvim 依赖: fd-find
  asroot apt-get install -y fd-find
}
# <}}}

# {{{> 在ubuntu上安装vimart
function install_vimart_on_ubuntu() {
  backup_vim_data
  install_dependency_on_ubuntu
  install_fonts_on_linux
  print_logo
}
# <}}}

