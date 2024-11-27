#!/bin/bash

source ${PWD}/scripts/color_print.sh

# {{{> 获取ubuntu版本
function get_ubuntu_version() {
    line=$(cat /etc/lsb-release | grep "DISTRIB_RELEASE")
    arr=(${line//=/ })
    version=(${arr[1]//./ })

    echo ${version[0]}
}
# <}}}

# {{{> 在ubuntu上源代码安装vim
function compile_vim_on_ubuntu() {
    # reference: https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source

    # remove vim*
    sudo apt-get remove --purge -y vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-nox
    # Install all the prerequisite libraries (including Git)
    sudo apt install -y libncurses5-dev libgtk2.0-dev libatk1.0-dev \
        libcairo2-dev libx11-dev libxpm-dev libxt-dev python2-dev \
        python3-dev ruby-dev lua5.2 liblua5.2-dev libperl-dev git

    if [ ! -d ~/.vimsrc ]; then
        rm -rf ~/.vimsrc
        git clone https://github.com/qeuroal/vimsrc.git ~/.vimsrc
    fi
    cd ~/.vimsrc
    ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk3 \
            --enable-cscope \
            --prefix=/usr/local

    make VIMRUNTIMEDIR=/usr/local/share/vim/vim91
    sudo make install

    # Set vim as your default editor with update-alternatives.
    # sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
    # sudo update-alternatives --set editor /usr/local/bin/vim
    # sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
    # sudo update-alternatives --set vi /usr/local/bin/vim

    cd -
    # rm -rf ~/.vimsrc
}
# <}}}

# {{{> 安装ubuntu必备软件
function install_software_on_ubuntu() {
    # echo -e "\033[32m===> Installing softwares...\033[0m"
    color_print "info" "Installing softwares..."
    sudo apt-get update

    version=$(get_ubuntu_version)
    if [ $version -eq 14 ];then
        sudo apt-get install -y cmake3
    else
        sudo apt-get install -y cmake
    fi

    sudo apt-get install -y build-essential fontconfig libfile-next-perl ack-grep git ripgrep
    # sudo apt-get install -y python3-dev python python-dev
    sudo apt-get install -y python3 python3-dev
    sudo apt-get install -y universal-ctags || sudo apt-get install -y exuberant-ctags
    
    if [ $version -gt 18 ]; then
        sudo apt-get install -y vim vim-gtk3
    else
        # ubuntu version <= 16
        if [ $version -le 16 ]; then
            sudo apt-get install -y libncurses-dev
            sudo apt-get install -y libclang-8-dev
            color_print "warning" "please exec \"python3 ./install.py --clang-completer --system-libclang\" to compile ycm"
        else
            color_print "warning" "please exec \"python3 ./install.py --clang-completer\" to compile ycm"
        fi

        vimVersion=`vim --version | grep "IMproved" | awk -F ' ' '{print $5}' | awk -F '.' '{print $1}'`
        if [ $version -le 8 ]; then
            compile_vim_on_ubuntu
        fi
    fi
}
# <}}}

# {{{> install_cpt_on_ubuntu
function install_cpt_on_ubuntu() {
    local cptScheme=$(get_complete_scheme)
    if [ "${cptScheme}" = "2" ]; then
        color_print "warning" "Installing ycm..."

        # 配置YCM版本
        version=$(get_ubuntu_version)
        if [ `cat ${HOME}/.vimrc.custom.config | grep -c "let g:completeScheme=2"` -a  $version -eq 22 -a `cat ${HOME}/.vimrc.custom.plugins | grep -c "# configure ycm commit"` = 0 ];then
            # Plug 'Valloric/YouCompleteMe', { 'commit' : '4556062839aa2e86f2f4f1c0b4532697d607af23' }
            echo "" >> ${HOME}/.vimrc.custom.plugins
            echo '" configure ycm commit' >> ${HOME}/.vimrc.custom.plugins
            echo 'Plug '"'"'Valloric/YouCompleteMe'"'"', { '"'"'commit'"'"' : '"'"'4556062839aa2e86f2f4f1c0b4532697d607af23'"'"' }' >> ${HOME}/.vimrc.custom.plugins
            echo "" >> ${HOME}/.vimrc.custom.plugins
        fi

        # python3 install.py --all --verbose 需要安装的依赖
        local install_choice=n
        read -n1 -p "Would you like to install dependencies of ycm? [y/n]" install_choice
        echo ""
        if [ "${install_choice}" = 'y' -o "${install_choice}" = 'Y' ]; then
            color_print "warning" "Installing dependencies of ycm..."
            # install golang on Ubuntu
            sudo apt install -y golang
            # install npm on Ubuntu
            sudo apt install -y npm
            # install java on Ubuntu
            sudo apt install -y openjdk-8-jdk
        fi

        # python 编译
        # python3 ~/.vim/plugged/YouCompleteMe/install.py --all
    elif [ "$cptScheme" = "3" ]; then
        color_print "warning" "Installing coc..."
        sudo apt install -y npm
    fi
}
# <}}}

#{{{> configure plugins
function configure_plugins_on_ubuntu() {
    configure_fzf_on_linux
    configure_tmux
    configure_shell
    configureCtags
}
#<}}}

# {{{> 在ubuntu上安装vimart
function install_vimart_on_ubuntu() {
    # backup data
    backup_vim_data
    # install prepare software
    install_software_on_ubuntu

    # copy files
    copy_files
    # install fonts
    install_fonts_on_linux
    # choose & install cpt
    choose_complete_scheme
    install_cpt_on_ubuntu
    # install vim plugins
    install_vim_plugins
    # configure vim plugins
    configure_plugins_on_ubuntu
    # print end
    print_logo
}
# <}}}

