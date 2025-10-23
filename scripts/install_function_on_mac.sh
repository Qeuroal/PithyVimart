#!/usr/bin/env bash

source ${PWD}/scripts/color_print.sh

# {{{> install softwares
function install_dependency_on_mac() {
    color_print "info" "Installing softwares..."
    # xcode-select --install
    brew install gcc cmake ctags-exuberant ack ripgrep fzf
    # node.js
    brew install node
    # snack.nvim 依赖: fd-find
    brew install fd
    # gnu softwares
    brew install gnu-sed gnu-tar
}
# <}}}

# {{{> install fonts
function install_fonts_on_mac() {
    if [ ! -e "./assets/remote/font/fonts.tar.gz" ]; then
        color_print "warning" "The fonts.tar.gz file does not exist. Cancel font installation..."
        return
    fi
    color_print "info" "Installing fonts..."

    # 解压fonts
    tar -zxvf ./assets/remote/font/fonts.tar.gz -C ./

    # instal Droid Sans
    rm -rf ~/Library/Fonts/droid_sans_mono
    cp -rf ./fonts/droid_sans_mono ~/Library/Fonts
    # install JetBrainsMono
    rm -rf ~/Library/Fonts/jetbrainsmono
    cp -rf ./fonts/jetbrainsmono ~/Library/Fonts
    # install MesloLGS
    rm -rf ~/Library/Fonts/meslolgs
    cp -rf ./fonts/meslolgs ~/Library/Fonts

    # 删除fonts
    rm -rf ./fonts
}
# <}}}

#{{{> configure plugins
function configure_on_mac() {
    link_dotfiles
    configure_shell
}
#<}}}

# {{{> install vimart
function install_vimart_on_mac() {
    backup_vim_data
    install_dependency_on_mac
    install_fonts_on_mac
    configure_on_mac
    print_logo
}
# <}}}




