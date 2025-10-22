#!/bin/bash

function install_software_on_archlinux() {
    if [ "$(has_sudo)" == "0" ]; then
        color_print "warning" "You are not the root user."
        return
    fi

    sudo pacman -S --noconfirm ctags automake gcc cmake python3 python2 ack git fontconfig ripgrep fzf
    # node.js
    sudo pacman -S --noconfirm npm
    # snack.nvim 依赖: fd-find
    sudo pacman -S fd

    # # 解决vim ycm 问题: ImportError: libtinfo.so.5: cannot open shared object file: No such file or directory
    # # 详见: https://github.com/chxuan/vimplus/issues/74
    # sudo ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5
}

#{{{> configure plugins
function configure_on_archlinux() {
    link_dotfiles
    configure_shell
}
#<}}}

# {{{> 在archlinux安装vimart
function install_vimart_on_archlinux() {
    backup_vim_data
    install_software_on_archlinux
    install_fonts_on_linux
    configure_on_archlinux
    print_logo
}
# <}}}
