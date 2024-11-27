
function install_software_on_archlinux() {
    # sudo pacman -S --noconfirm vim ctags automake gcc cmake python3 python2 ack git fontconfig
    # sudo ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5
    sudo pacman -S --noconfirm vim ctags automake gcc cmake python3 python2 ack git fontconfig ripgrep
    sudo ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5
}

function install_cpt_on_archlinux() {
    local cptScheme=$(get_complete_scheme)
    if [ "${cptScheme}" = "2" ]; then
        color_print "warning" "Installing ycm..."

        # python3 install.py --all --verbose 需要安装的依赖
        local install_choice=n
        read -n1 -p "Would you like to install dependencies of ycm? [y/n]" install_choice
        echo ""
        if [ "${install_choice}" = 'y' -o "${install_choice}" = 'Y' ]; then
            color_print "warning" "Installing dependencies of ycm..."
            # install go
            sudo pacman -S --noconfirm go
            # install npm
            sudo pacman -S --noconfirm npm
            # install java
            sudo pacman -S --noconfirm jdk8-openjdk
        fi
    elif [ "${cptScheme}" = "3" ]; then
        color_print "warning" "Installing cpt..."
        # install npm
        sudo pacman -S --noconfirm npm
    fi
}

#{{{> configure plugins
function configure_plugins_on_archlinux() {
    configure_fzf_on_linux
    configure_tmux
    configure_shell
    configureCtags
}
#<}}}

# {{{> 在archlinux安装vimart
function install_vimart_on_archlinux() {
    # backup data
    backup_vim_data
    # install prepare software
    install_software_on_archlinux

    # copy files
    copy_files
    # install fonts
    install_fonts_on_linux
    # choose & install ycm
    choose_complete_scheme
    install_cpt_on_archlinux
    # install vim plugins
    install_vim_plugins
    # configure vim plugins
    configure_plugins_on_archlinux
    # print end
    print_logo
}
# <}}}
