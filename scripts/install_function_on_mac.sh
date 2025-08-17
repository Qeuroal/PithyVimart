#!/bin/bash

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
}
# <}}}

# {{{> install fonts
function install_fonts_on_mac() {
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

#{{{> configure fzf
function configure_fzf_on_mac() {
    # configure in zshrc
    if [[ -f ${HOME}/.zshrc ]]
    then
        if test `cat ${HOME}/.zshrc | grep -c "# fzf:FZF_DEFAULT_COMMAND"` = 0
        then
            echo "" | tee -a ${HOME}/.zshrc > /dev/null
            echo "# fzf:FZF_DEFAULT_COMMAND" | tee -a ${HOME}/.zshrc > /dev/null
            echo "if type rg &> /dev/null; then" | tee -a ${HOME}/.zshrc > /dev/null
            echo "  export FZF_DEFAULT_COMMAND='rg --files'" | tee -a ${HOME}/.zshrc > /dev/null
            echo "  export FZF_DEFAULT_OPTS='-m'" | tee -a ${HOME}/.zshrc > /dev/null
            echo "fi" | tee -a ${HOME}/.zshrc > /dev/null
            echo "" | tee -a ${HOME}/.zshrc > /dev/null
        fi
    fi

    # configure in bashrc
    if test `cat ${HOME}/.bash_profile | grep -c "# fzf:FZF_DEFAULT_COMMAND"` = 0
    then
        echo "" | tee -a ${HOME}/.bash_profile > /dev/null
        echo "# fzf:FZF_DEFAULT_COMMAND" | tee -a ${HOME}/.bash_profile > /dev/null
        echo "if type rg &> /dev/null; then" | tee -a ${HOME}/.bash_profile > /dev/null
        echo "  export FZF_DEFAULT_COMMAND='rg --files'" | tee -a ${HOME}/.bash_profile > /dev/null
        echo "  export FZF_DEFAULT_OPTS='-m'" | tee -a ${HOME}/.bash_profile > /dev/null
        echo "fi" | tee -a ${HOME}/.bash_profile > /dev/null
        echo "" | tee -a ${HOME}/.bash_profile > /dev/null
    fi
}
#<}}}

#{{{> configure plugins
function configure_plugins_on_mac() {
    configure_fzf_on_mac
    configure_tmux
    configure_shell
}
#<}}}

# {{{> install vimart
function install_vimart_on_mac() {
    backup_vim_data
    install_dependency_on_mac
    copy_files
    install_fonts_on_mac
    configure_plugins_on_mac
    print_logo
}
# <}}}




