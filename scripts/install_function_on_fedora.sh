#!/bin/bash

source ${PWD}/scripts/color_print.sh

# {{{> 安装fedora必备软件
function install_software_on_fedora() {
    # echo -e "\033[32m===> Installing softwares...\033[0m"
    color_print "info" "Installing softwares..."

    # sudo dnf install -y vim-enhanced ctags automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel fontconfig ack git
    sudo dnf install -y vim-enhanced ctags gcc make gcc gcc-c++ cmake python3-devel ripgrep
}
# <}}}

# {{{> install_cpt_on_fedora
function install_cpt_on_fedora() {
    local cptScheme=$(get_complete_scheme)
    if [ "${cptScheme}" = "2" ]; then
        color_print "warning" "Installing ycm..."

        # python3 install.py --all --verbose 需要安装的依赖
        local install_choice=n
        read -n1 -p "Would you like to install dependencies of ycm? [y/n]" install_choice
        echo ""
        if [ "${install_choice}" = 'y' -o "${install_choice}" = 'Y' ]; then
            color_print "warning" "Installing dependencies of ycm..."
            # install golang
            sudo dnf install -y golang
            go mod init ${HOME}/.vim/plugged/YouCompleteMe
            # install npm
            sudo dnf install -y npm
            # install java
            # sudo dnf install -y openjdk-8-jdk
        fi

        # python 编译
        # python3 ~/.vim/plugged/YouCompleteMe/install.py --all
    elif [ "$cptScheme" = "3" ]; then
        color_print "warning" "Installing coc..."
        sudo dnf install -y npm
    fi
}
# <}}}

#{{{> configure plugins
function configure_plugins_on_fedora() {
    configure_fzf_on_linux
    configure_tmux
    configure_shell
    configureCtags
}
#<}}}

# {{{> 在fedora上安装vimart
function install_vimart_on_fedora() {
    # backup data
    backup_vim_data
    # install prepare software
    install_software_on_fedora

    # copy files
    copy_files
    # install fonts
    install_fonts_on_linux
    # choose & install ycm
    choose_complete_scheme
    install_cpt_on_fedora
    # install vim plugins
    install_vim_plugins
    # configure vim plugins
    configure_plugins_on_fedora
    # print end
    print_logo
}
# <}}}

