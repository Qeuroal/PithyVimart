#!/usr/bin/env bash

source ${PWD}/scripts/color_print.sh

# {{{> 安装fedora必备软件
function install_software_on_fedora() {
    if [[ "$(has_sudo)" == "0" ]]; then
        color_print "warning" "You are not the root user."
        return
    fi

    color_print "info" "Installing softwares..."

    # sudo dnf install -y vim-enhanced ctags automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel fontconfig ack git
    sudo dnf install -y vim-enhanced ctags gcc make gcc gcc-c++ cmake python3-devel fontconfig ripgrep fzf
    # node.js
    sudo dnf install -y npm
    # snack.nvim 依赖: fd-find
    sudo dnf install fd-find
}
# <}}}

#{{{> configure plugins
function configure_on_fedora() {
    link_dotfiles
    configure_shell
}
#<}}}

# {{{> 在fedora上安装vimart
function install_vimart_on_fedora() {
    backup_vim_data
    install_software_on_fedora
    copy_files
    install_fonts_on_linux
    configure_on_fedora
    print_logo
}
# <}}}

