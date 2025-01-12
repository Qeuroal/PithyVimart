#!/bin/bash

function install_software_on_archlinux() {
    # sudo pacman -S --noconfirm vim ctags automake gcc cmake python3 python2 ack git fontconfig
    # sudo ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5
    sudo pacman -S --noconfirm ctags automake gcc cmake python3 python2 ack git fontconfig ripgrep fzf npm
    sudo ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5
}

#{{{> configure plugins
function configure_plugins_on_archlinux() {
    configure_fzf_on_linux
    configure_tmux
    configure_shell
}
#<}}}

# {{{> 在archlinux安装vimart
function install_vimart_on_archlinux() {
    backup_vim_data
    install_software_on_archlinux
    install_fonts_on_linux
    configure_plugins_on_archlinux
    print_logo
}
# <}}}
