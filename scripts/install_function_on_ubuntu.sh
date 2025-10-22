#!/usr/bin/env bash

source ${PWD}/scripts/color_print.sh

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
    if [ "$(has_sudo)" == "0" ]; then
        color_print "warning" "You are not the root user."
        return
    fi

    # echo -e "\033[32m===> Installing softwares...\033[0m"
    color_print "info" "Installing softwares..."
    sudo apt-get update

    version=$(get_ubuntu_version)
    if [ $version -eq 14 ];then
        sudo apt-get install -y cmake3
    else
        sudo apt-get install -y cmake
    fi

    sudo apt-get install -y build-essential fontconfig libfile-next-perl ack-grep git ripgrep fzf
    # sudo apt-get install -y python3-dev python python-dev
    sudo apt-get install -y python3 python3-dev
    sudo apt-get install -y universal-ctags || sudo apt-get install -y exuberant-ctags
    # node.js
    sudo apt-get install -y npm
    # snack.nvim 依赖: fd-find
    sudo apt-get install -y fd-find
}
# <}}}

#{{{> configure plugins
function configure_on_ubuntu() {
    link_dotfiles
    configure_shell
}
#<}}}

# {{{> 在ubuntu上安装vimart
function install_vimart_on_ubuntu() {
    backup_vim_data
    install_dependency_on_ubuntu
    install_fonts_on_linux
    configure_on_ubuntu
    print_logo
}
# <}}}

