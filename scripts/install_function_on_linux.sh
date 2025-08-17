#!/bin/bash

source ${PWD}/scripts/color_print.sh
source ${PWD}/scripts/install_function_on_ubuntu.sh
source ${PWD}/scripts/install_function_on_archlinux.sh
source ${PWD}/scripts/install_function_on_fedora.sh

# {{{>安装linux平台字体
function install_fonts_on_linux() {
    # echo -e "\033[32m===> Installing fonts...\033[0m"
    color_print "info" "Installing fonts..."
    mkdir -p ~/.local/share/fonts

    # 解压fonts
    tar -zxvf ./assets/remote/font/fonts.tar.gz -C ./

    # install Droid Sans Mono Nerd Font Complete
        # rm -rf ~/.local/share/fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf
        # cp ./fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf ~/.local/share/fonts
    rm -rf ~/.local/share/fonts/droid_sans_mono
    cp -rf ./fonts/droid_sans_mono ~/.local/share/fonts

    # install MesloLGS
        # rm -rf ~/.local/share/fonts/MesloLGS\ NF\ Bold\ Italic.ttf
        # rm -rf ~/.local/share/fonts/MesloLGS\ NF\ Bold.ttf
        # rm -rf ~/.local/share/fonts/MesloLGS\ NF\ Italic.ttf
        # rm -rf ~/.local/share/fonts/MesloLGS\ NF\ Regular.ttf

        # cp -f ./fonts/MesloLGS\ NF\ Bold\ Italic.ttf ~/.local/share/fonts
        # cp -f ./fonts/MesloLGS\ NF\ Bold.ttf ~/.local/share/fonts
        # cp -f ./fonts/MesloLGS\ NF\ Italic.ttf ~/.local/share/fonts
        # cp -f ./fonts/MesloLGS\ NF\ Regular.ttf ~/.local/share/fonts
    rm -rf ~/.local/share/fonts/meslolgs
    cp -rf ./fonts/meslolgs ~/.local/share/fonts

    # install JetBrainsMono
    # rm -rf ~/.local/share/fonts/JetBrainsMono\-Regular.ttf
    # rm -rf ~/.local/share/fonts/JetBrainsMonoNL\-Regular.ttf

    # cp -f ./fonts/JetBrainsMonoNL\-Regular.ttf ~/.local/share/fonts
    # cp -f ./fonts/JetBrainsMono\-Regular.ttf ~/.local/share/fonts

    rm -rf ~/.local/share/fonts/jetbrainsmono
    cp -rf ./fonts/jetbrainsmono ~/.local/share/fonts

    # 删除fonts
    rm -rf ./fonts

    fc-cache -vf ~/.local/share/fonts
}
# <}}}

# {{{> 在linux平上台安装vimart
function install_vimart_on_linux() {
    distro=`get_linux_distro`
    echo "Linux distro: "${distro}

    if [ ${distro} == "Ubuntu" ]; then
        install_vimart_on_ubuntu
    elif [ ${distro} == "Deepin" ]; then
        echo "not support ${distro}"
    elif [ ${distro} == "LinuxMint" ]; then
        echo "not support ${distro}"
    elif [ ${distro} == "elementaryOS" ]; then
        echo "not support ${distro}"
    elif [ ${distro} == "Debian" ]; then
        echo "not support ${distro}"
    elif [ ${distro} == "Raspbian" ]; then
        echo "not support ${distro}"
    elif [ ${distro} == "UOS" ]; then
        echo "not support ${distro}"
    elif [ ${distro} == "Kali" ]; then
        echo "not support ${distro}"
    elif [ ${distro} == "Parrot" ]; then
        echo "not support ${distro}"
    elif [ ${distro} == "CentOS" ]; then
        echo "not support ${distro}"
    elif [ ${distro} == "fedora" ]; then
        install_vimart_on_fedora
    elif [ ${distro} == "openSUSE" ]; then
        echo "not support ${distro}"
    elif [ ${distro} == "ArchLinux" ]; then
        # echo "not support ${distro}"
        install_vimart_on_archlinux
    elif [ ${distro} == "ManjaroLinux" ]; then
        # echo "not support ${distro}"
        install_vimart_on_archlinux
    elif [ ${distro} == "Gentoo" ]; then
        echo "not support ${distro}"
    elif [ ${distro} == "Alpine" ]; then
        echo "not support ${distro}"
    else
        echo "Not support linux distro: "${distro}
    fi
}
# <}}}

#{{{> copy ycm config
function copy_cpt_config() {
    srcpath=${PWD}
    destpath=$HOME
    if [ "$#" = "1"  ]; then
        srcpath=${PWD}
        destpath=$1
    elif [ "$#" = "2"  ]; then
        srcpath=$1
        destpath=$2
    fi

    if [ `ls ${destpath}/.vim/plugged | grep -c YouCompleteMe` != 0  ]; then
        rm -rf ${destpath}/.vimrc.cpt.config
        ln -s ${srcpath}/configuration/vimrc.cpt.config ${destpath}/.vimrc.cpt.config
    fi
}
#<}}}

#{{{> copy reference-user's config-files and plugin-files
function copy_reference_usr_file() {
    referenceUser=${VIMART_REFERENCE_USER}
    if [ "${referenceUser}" = "" ]; then
        return
    fi

    color_print "warning" "reference user: ${referenceUser}, userhome: ${userhome}"
    destpath=$HOME
    if [ "$#" = "1" ]; then
        destpath=$1
    fi
    local userhome=$(eval echo ~${referenceUser})

    if [ -d "${userhome}/.vim" ]; then
        if [ "$(has_sudo)" == "1" ]; then
            sudo cp -rf ${userhome}/.vim ${destpath}
        else
            color_print "warning" "You are not the root user."
        fi
    else
        color_print "warning" "don't exist ${userhome}/.vim"
    fi

    if [ -f "${userhome}/.vimrc.custom.config" ]; then
        cp -f ${userhome}/.vimrc.custom.config ${destpath}
    else
        color_print "warning" "don't exist ${userhome}/.vimrc.custom.config"
    fi

    if [ -f "${userhome}/.vimrc.custom.plugins" ]; then
        cp -f ${userhome}/.vimrc.custom.plugins ${destpath}
    else
        color_print "warning" "don't exist ${userhome}/.vimrc.custom.plugins"
    fi

    if [ -f "${userhome}/.vim/coc-settings.json" ]; then
        rm -rf ${destpath}/.vim/coc-settings.json
        cp -f `realpath ${userhome}/.vim/coc-settings.json` ${destpath}/.vim/coc-settings.json
    fi

    if [ -d "${userhome}/.config/coc" ]; then
        rm -rf ${destpath}/.config/coc
        cp -rf `realpath ${userhome}/.config/coc` ${destpath}/.config/
    fi
}
#<}}}

#{{{> config vimart dependency
function config_vimart_dependency() {
    color_print "info" "Configuring vimart dependency..."

    srcpath=${PWD}
    destpath=$HOME
    if [ "$#" = "1" ]; then
        srcpath=${PWD}
        destpath=$1
    elif [ "$#" = "2" ]; then
        srcpath=$1
        destpath=$2
    fi

    configure_fzf_on_linux ${srcpath} ${destpath}
    configure_tmux ${srcpath} ${destpath}
    configure_aliases ".zshrc" ${srcpath} ${destpath}
    configure_aliases ".bashrc" ${srcpath} ${destpath}
    configure_aliases ".bash_profile" ${srcpath} ${destpath}
    configure_eof ${srcpath} ${destpath}
    configureCtags ${srcpath} ${destpath}
}
#<}}}

#{{{> modidy user chown
function chown_user_permission() {
    local username="${VIMART_CHOWN_USER}"
    if [ "${username}" = "" ]; then
        color_print "info" "cancel to chown user's .vim*"
        return 0
    fi

    local userhome=$(eval echo ~${username})
    color_print "info" "chown .vim* to user ${username}, userhome: ${userhome}"

    if [ -d "${userhome}/.vim" ]; then
        chown -R ${username}:${username} ${userhome}/.vim
    fi

    if [ -e "${userhome}/.vimart" ]; then
        chown -R ${username}:${username} ${userhome}/.vimart
    fi

    if [ -e "${userhome}/.vimrc" ]; then
        chown -R ${username}:${username} ${userhome}/.vimrc
    fi

    if [ -e "${userhome}/.vimrc.custom.config" ]; then
        chown -R ${username}:${username} ${userhome}/.vimrc.custom.config
    fi

    if [ -e "${userhome}/.vimrc.custom.plugins" ]; then
        chown -R ${username}:${username} ${userhome}/.vimrc.custom.plugins
    fi

    if [ -e "${userhome}/.ycm_extra_conf.py" ]; then
        chown -R ${username}:${username} ${userhome}/.ycm_extra_conf.py
    fi

    if [ -e "${userhome}/.vimrc.cpt.config" ]; then
        chown -R ${username}:${username} ${userhome}/.vimrc.cpt.config
    fi

    if [ -e "${userhome}/.bashrc" ]; then
        chown -R ${username}:${username} ${userhome}/.bashrc
    fi

    if [ -e "${userhome}/.ctags" ]; then
        chown -R ${username}:${username} ${userhome}/.ctags
    fi

    if [ -e "${userhome}/.tmux.conf" ]; then
        chown -R ${username}:${username} ${userhome}/.tmux.conf
    fi

    if [ -e "${userhome}/.aliases" ]; then
        chown -R ${username}:${username} ${userhome}/.aliases
    fi
}
#<}}}

#{{{> local install vimart
function local_install_vimart_on_linux() {
    srcpath="${VIMART_SRC_PATH}"
    if [ "${srcpath}" = "" ]; then
        srcpath=${PWD}
    else
        srcpath="`realpath ${VIMART_SRC_PATH}`"
    fi
    color_print "info" "source path: $srcpath"

    destpath="${VIMART_DEST_PATH}"
    if [ "${destpath}" = "" ]; then
        destpath=$HOME
    else
        destpath="`realpath ${VIMART_DEST_PATH}`"
    fi
    color_print "info" "destination path: $destpath"

    copy_reference_usr_file ${destpath}
    copy_files ${srcpath} ${destpath}
    copy_cpt_config ${srcpath} ${destpath}
    config_vim_cpt ${srcpath} ${destpath}
    config_vimart_dependency ${srcpath} ${destpath}
    chown_user_permission
}
#<}}}



