#!/bin/bash

source ${PWD}/scripts/color_print.sh

# {{{> install softwares
function install_softwares_on_mac() {
    # echo -e "\033[32m===> Installing softwares...\033[0m"
    color_print "info" "Installing softwares..."
    # xcode-select --install
    brew install macvim gcc cmake ctags-exuberant ack ripgrep
    local macvimPath=`realpath \`which mvim\` | awk -F / '{
        path=""
        for (i = 1; i < NF - 2; i++)
        {
            if ($i) path=path"/"$i
        }
        print path
    }'`
    ln -sf ${macvimPath} /Applications

}
# <}}}

# {{{> install fonts
function install_fonts_on_mac() {
    # echo -e "\033[32m===> Installing fonts...\033[0m"
    color_print "info" "Installing fonts..."

    # 解压fonts
    tar -zxvf ./assets/packages/font/fonts.tar.gz -C ./

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

    #################################################################
    ## 待测试
    #################################################################
    # # remove Droid Sans 字体
    # rm -rf ~/Library/Fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf
    # cp ./fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf ~/Library/Fonts

    # # rm MesloLGS
    # rm -rf ~/Library/Fonts/MesloLGS\ NF\ Bold\ Italic.ttf
    # rm -rf ~/Library/Fonts/MesloLGS\ NF\ Bold.ttf
    # rm -rf ~/Library/Fonts/MesloLGS\ NF\ Italic.ttf
    # rm -rf ~/Library/Fonts/MesloLGS\ NF\ Regular.ttf

    # cp -f ./fonts/MesloLGS\ NF\ Bold\ Italic.ttf ~/Library/Fonts
    # cp -f ./fonts/MesloLGS\ NF\ Bold.ttf ~/Library/Fonts
    # cp -f ./fonts/MesloLGS\ NF\ Italic.ttf ~/Library/Fonts
    # cp -f ./fonts/MesloLGS\ NF\ Regular.ttf ~/Library/Fonts
}
# <}}}

# {{{> install ycm
function install_cpt_on_mac() {
    local cptScheme=$(get_complete_scheme)

    if [ "${cptScheme}" = "2" ]; then
        color_print "warning" "Installing ycm..."

        #########################################
        ## 待测试 !!!!!!!!!!!!!!!!!!!          ##
        #########################################

        # install dependency
        local install_choice=n
        read -n1 -p "Would you like to install dependencies of ycm? [y/n]" install_choice
        echo ""
        if [ "${install_choice}" = 'y' -o "${install_choice}" = 'Y' ]; then
            color_print "warning" "Installing dependencies of ycm..."
            brew install cmake python go nodejs
        fi
        # brew install java

        # python 编译
        # python3 ~/.vim/plugged/YouCompleteMe/install.py --all
    elif [ "${cptScheme}" = "3" ]; then
        color_print "warning" "Installing coc..."
        brew install nodejs
    fi
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
    # configure fzf
    configure_fzf_on_mac
    configure_tmux
    configure_shell
    configureCtags
}
#<}}}

# {{{> install vimart
function install_vimart_on_mac() {
    # backup data
    backup_vim_data
    # install prepare software
    install_softwares_on_mac
    # copy files
    copy_files
    #install fonts
    install_fonts_on_mac
    # choose & install cpt
    choose_complete_scheme
    install_cpt_on_mac
    # install vim plugins
    install_vim_plugins
    # config vim plugins
    configure_plugins_on_mac
    # print end
    print_logo
}
# <}}}




