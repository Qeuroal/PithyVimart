#!/bin/bash

#{{{> backup personal vim configure
function backup_vim_data() {
    # echo -e "\033[32m===> Backuping vim data...\033[0m"
    color_print "info" "Backuping vim data..."
}
#<}}}

#{{{> copy and link files
function copy_files() {
    # echo -e "\033[32m===> Copying files...\033[0m"
    color_print "info" "Copying files..."

    local srcPath=${PWD}
    local destPath=$HOME
    if [ "$#" = "1" ]; then
        srcPath=${PWD}
        destPath="$1"
    elif [ "$#" = "2" ]; then
        srcPath="$1"
        destPath="$2"
    fi

    color_print "info" "srcPath: $srcPath"
    color_print "info" "dstPath: $destPath"

    # .vimrc
    rm -rf ${destPath}/.vimrc
    ln -s ${srcPath}/configuration/.vimrc ${destPath}

    # vim-plug by download from github
        # curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        # https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # .vimrc.custom.plugins
    # rm -rf ${destPath}/.vimrc.custom.plugins
    if [ ! -e "${destPath}/.vimrc.custom.plugins" ]; then
        cp ${srcPath}/configuration/.vimrc.custom.plugins ${destPath}
    fi

    # .vimrc.custom.config
    # rm -rf ${destPath}/.vimrc.custom.config
    if [ ! -e "${destPath}/.vimrc.custom.config" ]; then
        cp ${srcPath}/configuration/.vimrc.custom.config ${destPath}
    fi

    # .vim/color
    mkdir -p ${destPath}/.vim
    rm -rf ${destPath}/.vim/colors
    ln -s ${srcPath}/colors ${destPath}/.vim/

    # .vim/bin
    mkdir -p ${destPath}/.vim/bin

    # vim-plug by copy
    cp -rf ${srcPath}/autoload ${destPath}/.vim/

    # ftplugin
    rm -rf ${destPath}/.vim/ftplugin
    ln -s ${srcPath}/ftplugin ${destPath}/.vim/

    # settings
    rm -rf ${destPath}/.vim/settings
    ln -s ${srcPath}/settings ${destPath}/.vim/

    # ultisnips
    rm -rf ${destPath}/.vim/UltiSnips
    ln -s ${srcPath}/plugin_configuration/UltiSnips ${destPath}/.vim/UltiSnips

    # .vimart
    rm -rf ${destPath}/.vimart
    ln -s ${srcPath} ${destPath}/.vimart

    # .vimrc.cpt.config
    rm -rf ~/.vimrc.cpt.config
    ln -s ${PWD}/configuration/vimrc.cpt.config ~/.vimrc.cpt.config
}
#<}}}

#{{{> 判断文件是否存在
function is_exist_file()
{
    local filename=$1
    if [ -f $filename ]; then
        echo 1
    else
        echo 0
    fi
}
#<}}}

#{{{> config vim cpt
function config_vim_cpt() {
    # 设置路径变量
    local srcPath=${PWD}
    local destPath=$HOME
    if [ "$#" = "1"  ]; then
        srcPath=${PWD}
        destPath="$1"
    elif [ "$#" = "2"  ]; then
        srcPath="$1"
        destPath="$2"
    fi

    # complete 配置
    local vimrc_custom_config=${destPath}/.vimrc.custom.config
    local exist_vimrc_custom_config=$(is_exist_file ${vimrc_custom_config})
    if [ ${exist_vimrc_custom_config} -eq 0 ]; then
        return
    fi

    local cpt_scheme_count=`cat ${vimrc_custom_config} | grep -c "let g:completeScheme"`
    if [ ${cpt_scheme_count} -ne 1 ]; then
        return
    fi

    local cpt_scheme=`cat ${vimrc_custom_config} | grep "let g:completeScheme" | awk -F '=' '{print $2}'`
    if [ ${cpt_scheme} -eq 2 ]; then
    # if [ ${is_vimrc_ycm_config_exist} == 1 ]; then
        # 添加 ycm_extra_conf 文件
        color_print "info" "Coping the .ycm_tra_conf.py file..."
        local ycm_extra_conf_path=${srcPath}"/configuration/.ycm_extra_conf.py"
        cp -f ${ycm_extra_conf_path} ${destPath}

        ###############################################################################
        # # 使用自带的 ycm_extra_conf 文件 (!!!!!!!!!!!!!!!!!! 舍弃 !!!!!!!!!!!!!!!!!!)
        # isYcmExtraConfExist=$(is_exist_file ${ycm_extra_conf_path})
        # if [ ${isYcmExtraConfExist} == 0 ]; then
        #     ycm_extra_conf_path=${destPath}"/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py"
        #     # echo -e "\033[32m===============================>Existing ${ycm_extra_conf_path}\033[0m"
        #     # color_print "info" "===============================>Existing ${ycm_extra_conf_path}"
        #     # cp -f ~/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py ~
        # fi
        ###############################################################################
    elif [ ${cpt_scheme} -eq 3 ]; then
        color_print "info" "Configuring coc ..."
        vim -c "CocInstall coc-marketplace coc-clangd coc-pyright coc-sh coc-vimlsp coc-snippets coc-texlab "
        # vim -c "CocInstall coc-explorer"
    fi

}
#<}}}

#{{{> install vim plugins
function install_vim_plugins() {
    # echo -e "\033[32m===> Installing plugins...\033[0m"
    color_print "info" "Installing plugins..."
    vim -c "PlugInstall" -c "q" -c "q"
    config_vim_cpt
}
#<}}}

#{{{> print vimart's logo
function print_logo() {
    local color="$(tput setaf 6)"
    local normal="$(tput sgr0)"
    printf "${color}"
    echo ''
    echo '888     888 d8b                      d8888         888    '
    echo '888     888 Y8P                     d88888         888    '
    echo '888     888                        d88P888         888    '
    echo 'Y88b   d88P 888 88888b.d88b.      d88P 888 888d888 888888 '
    echo ' Y88b d88P  888 888 "888 "88b    d88P  888 888P"   888    '
    echo '  Y88o88P   888 888  888  888   d88P   888 888     888    '
    echo '   Y888P    888 888  888  888  d8888888888 888     Y88b.  '
    echo '    Y8P     888 888  888  888 d88P     888 888      "Y888 by Qeuroal.'
    echo ''
    echo 'Finish vimart installment!'
    echo 'Just enjoy it!'
    echo ''
    printf "${normal}"
}
#<}}}

#{{{> 获取linux发行版名称
function get_linux_distro()
{
    if grep -Eq "Ubuntu" /etc/*-release; then
        echo "Ubuntu"
    elif grep -Eq "Deepin" /etc/*-release; then
        echo "Deepin"
    elif grep -Eq "Raspbian" /etc/*-release; then
        echo "Raspbian"
    elif grep -Eq "uos" /etc/*-release; then
        echo "UOS"
    elif grep -Eq "LinuxMint" /etc/*-release; then
        echo "LinuxMint"
    elif grep -Eq "elementary" /etc/*-release; then
        echo "elementaryOS"
    elif grep -Eq "Debian" /etc/*-release; then
        echo "Debian"
    elif grep -Eq "Kali" /etc/*-release; then
        echo "Kali"
    elif grep -Eq "Parrot" /etc/*-release; then
        echo "Parrot"
    elif grep -Eq "CentOS" /etc/*-release; then
        echo "CentOS"
    elif grep -Eq "fedora" /etc/*-release; then
        echo "fedora"
    elif grep -Eq "openSUSE" /etc/*-release; then
        echo "openSUSE"
    elif grep -Eq "Arch Linux" /etc/*-release; then
        echo "ArchLinux"
    elif grep -Eq "ManjaroLinux" /etc/*-release; then
        echo "ManjaroLinux"
    elif grep -Eq "Gentoo" /etc/*-release; then
        echo "Gentoo"
    elif grep -Eq "alpine" /etc/*-release; then
        echo "Alpine"
    else
        echo "Unknown"
    fi
}
#<}}}

#{{{> 获取当前时间戳
function get_now_timestamp() {
    local cur_sec_and_ns=`date '+%s-%N'`
    echo ${cur_sec_and_ns%-*}
}
#<}}}

#{{{> configure fzf
function configure_fzf_on_linux() {
    local srcPath=${PWD}
    local destPath=$HOME
    if [ "$#" = "1" ]; then
        srcPath=${PWD}
        destPath="$1"
    elif [ "$#" = "2" ]; then
        srcPath="$1"
        destPath="$2"
    fi

    # configure in zshrc
    if [[ -f ${destPath}/.zshrc ]]
    then
        if test `cat ${destPath}/.zshrc | grep -c "# fzf:FZF_DEFAULT_COMMAND"` = 0
        then
            echo "" | tee -a ${destPath}/.zshrc > /dev/null
            echo "# fzf:FZF_DEFAULT_COMMAND" | tee -a ${destPath}/.zshrc > /dev/null
            echo "if type rg &> /dev/null; then" | tee -a ${destPath}/.zshrc > /dev/null
            echo "  export FZF_DEFAULT_COMMAND='rg --files'" | tee -a ${destPath}/.zshrc > /dev/null
            echo "  export FZF_DEFAULT_OPTS='-m'" | tee -a ${destPath}/.zshrc > /dev/null
            echo "fi" | tee -a ${destPath}/.zshrc > /dev/null
            echo "" | tee -a ${destPath}/.zshrc > /dev/null
        fi
    fi

    # configure in bashrc
    if test `cat ${destPath}/.bashrc | grep -c "# fzf:FZF_DEFAULT_COMMAND"` = 0
    then
        echo "" | tee -a ${destPath}/.bashrc > /dev/null
        echo "# fzf:FZF_DEFAULT_COMMAND" | tee -a ${destPath}/.bashrc > /dev/null
        echo "if type rg &> /dev/null; then" | tee -a ${destPath}/.bashrc > /dev/null
        echo "  export FZF_DEFAULT_COMMAND='rg --files'" | tee -a ${destPath}/.bashrc > /dev/null
        echo "  export FZF_DEFAULT_OPTS='-m'" | tee -a ${destPath}/.bashrc > /dev/null
        echo "fi" | tee -a ${destPath}/.bashrc > /dev/null
        echo "" | tee -a ${destPath}/.bashrc > /dev/null
    fi
}
#<}}}

#{{{> config tmux
function configure_tmux() {
    local srcPath=${PWD}
    local destPath=$HOME
    if [ "$#" = "1" ]; then
        srcPath=${PWD}
        destPath="$1"
    elif [ "$#" = "2" ]; then
        srcPath="$1"
        destPath="$2"
    fi

    # copy .tmux.conf
    if [ ! -f "${destPath}/.tmux.conf" ]
    then
        local targetFilePath="${srcPath}/assets/packages/dotfiles/.tmux.conf"
        if [ -f ${targetFilePath} ]
        then
            cp -rf ${targetFilePath} ${destPath}/.tmux.conf
        fi
    fi

    # 取消tmux的escape延迟
    if [ ! -f "${destPath}/.tmux.conf" ] \
        || [ `cat ${destPath}/.tmux.conf | grep -c "set -sg escape-time 1"` = 0 ]
    then
        echo '# 取消tmux的escape延迟' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo 'set -sg escape-time 1' | tee -a ${destPath}/.tmux.conf > /dev/null
    fi

    # 配置vim-tmux-navigator冲突
    if [ ! -f "${destPath}/.tmux.conf" ] \
        || [ `cat ${destPath}/.tmux.conf | grep -c "# 配置vim-tmux-navigator冲突"` = 0 ]
    then
        echo '' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '# 配置vim-tmux-navigator冲突' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo 'is_vim="ps -o state= -o comm= -t '"'"'#{pane_tty}'"'"' \' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '    | grep -iqE '"'"'^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"'"'"' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo 'is_fzf="ps -o state= -o comm= -t '"'"'#{pane_tty}'"'"' \' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '    | grep -iqE '"'"'^[^TXZ ]+ +(\\S+\\/)?fzf$'"'"'"' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo 'bind -n C-h run "($is_vim && tmux send-keys C-h) || \' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '                 tmux select-pane -L"' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo 'bind -n C-j run "($is_vim && tmux send-keys C-j)  || \' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '                 ($is_fzf && tmux send-keys C-j) || \' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '                 tmux select-pane -D"' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo 'bind -n C-k run "($is_vim && tmux send-keys C-k) || \' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '                 ($is_fzf && tmux send-keys C-k)  || \' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '                 tmux select-pane -U"' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo 'bind -n C-l run "($is_vim && tmux send-keys C-l) || \' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '                 tmux select-pane -R"' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '# bind-key -n C-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo 'if-shell -b '"'"'[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]'"'"' \' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '    "bind-key -n '"'"'C-\\'"'"' if-shell \"$is_vim\" '"'"'send-keys C-\\'"'"'  '"'"'select-pane -l'"'"'"' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo 'if-shell -b '"'"'[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]'"'"' \' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '    "bind-key -n '"'"'C-\\'"'"' if-shell \"$is_vim\" '"'"'send-keys C-\\\\'"'"'  '"'"'select-pane -l'"'"'"' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '' | tee -a ${destPath}/.tmux.conf > /dev/null
        echo '' | tee -a ${destPath}/.tmux.conf > /dev/null
    fi
}
#<}}}

#{{{> configure aliases
function configureAliases() {
    local destFile=".zshrc"
    local srcPath=${PWD}
    local destPath=$HOME
    if [ "$#" = "1" ]; then
        destFile="$1"
    elif [ "$#" = "2" ]; then
        destFile="$1"
        destPath="$2"
    elif [ "$#" = "3" ]; then
        destFile="$1"
        srcPath="$2"
        destPath="$3"
    fi

    local dstpath="${destPath}/${destFile}"

    if [ ! -e "${destPath}/.aliases" ]; then
        cp -rf ${srcPath}/assets/packages/dotfiles/.aliases ${destPath}/.aliases
    fi

    if [[ -f "${dstpath}" ]]; then
        if test `cat ${dstpath} | grep -c '# import aliases'` = 0; then
            echo "" | tee -a ${dstpath} > /dev/null
            echo '# import aliases' | tee -a ${dstpath} > /dev/null
            # echo 'if [[ -f ~/.aliases ]]; then {source ~/.aliases}; fi'
            echo '[[ -f ~/.aliases ]] && source ~/.aliases' | tee -a ${dstpath} > /dev/null
            echo "" | tee -a ${dstpath} > /dev/null
        fi
    fi
}
#<}}}

#{{{> config EOF
function configureEof() {
    local srcPath=${PWD}
    local destPath=$HOME
    if [ "$#" = "1" ]; then
        srcPath=${PWD}
        destPath="$1"
    elif [ "$#" = "2" ]; then
        srcPath="$1"
        destPath="$2"
    fi

    if [[ -f ${destPath}/.zshrc ]]
    then
        # 设置ctrl+d不退出
        if test `cat ${destPath}/.zshrc | grep -c "set -o IGNOREEOF"` = 0
        then
            echo "" | tee -a ${destPath}/.zshrc > /dev/null
            echo "# prevent tmux exiting with Ctrl-d" | tee -a ${destPath}/.zshrc > /dev/null
            echo "set -o IGNOREEOF" | tee -a ${destPath}/.zshrc > /dev/null
            echo "" | tee -a ${destPath}/.zshrc > /dev/null
        fi
    fi

    if [[ -f ${destPath}/.bashrc ]]
    then
        # 设置ctrl+d不退出
        if test `cat ${destPath}/.bashrc | grep -c "set -o ignoreeof"` = 0
        then
            echo "" | tee -a ${destPath}/.bashrc > /dev/null
            echo "# prevent tmux exiting with Ctrl-d" | tee -a ${destPath}/.bashrc > /dev/null
            echo "set -o ignoreeof" | tee -a ${destPath}/.bashrc > /dev/null
            echo "ignoreeof=3" | tee -a ${destPath}/.bashrc > /dev/null
            echo "" | tee -a ${destPath}/.bashrc > /dev/null
        fi
    elif [[ -f ${destPath}/.bash_profile ]]
    then
        if test `cat ${destPath}/.bash_profile | grep -c "set -o IGNOREEOF"` = 0
        then
            echo "" | tee -a ${destPath}/.bash_profile > /dev/null
            echo "# prevent tmux exiting with Ctrl-d" | tee -a ${destPath}/.bash_profile > /dev/null
            echo "set -o IGNOREEOF" | tee -a ${destPath}/.bash_profile > /dev/null
            echo "" | tee -a ${destPath}/.bash_profile > /dev/null
        fi

    fi
}
#<}}}

#{{{> config shell
function configure_shell() {
    configureAliases ".zshrc"
    configureAliases ".bashrc"
    configureAliases ".bash_profile"

    configureEof
}
#<}}}

#{{{> config ctags
function configureCtags() {
    local srcPath=${PWD}
    local destPath=$HOME
    if [ "$#" = "1" ]; then
        srcPath=${PWD}
        destPath="$1"
    elif [ "$#" = "2" ]; then
        srcPath="$1"
        destPath="$2"
    fi

    local targetFile="${destPath}/.ctags"
    if [[ ! -f ${targetFile} ]]; then
        touch ${targetFile}
    fi

    # copy mdctags
    type=$(uname)
    if [ "${type}" = "Darwin" ]; then
        cp -rf ${srcPath}/assets/packages/mdctags/mdctags_Darwin ${destPath}/.vim/bin/mdctags
    elif [ ${type} = "Linux" ]; then
        local tp=$(uname -a)
        if [[ $tp =~ "Android" ]]; then
            echo "mdctags doesn't support platform type: Android"
        else
            local distro=`get_linux_distro`
            local targetFile="${srcPath}/assets/packages/mdctags/mdctags_${distro}"
            if [[ -f ${targetFile} ]]; then
                cp -rf ${targetFile} ${destPath}/.vim/bin/mdctags
            fi
        fi
    else
        echo "mdctags doesn't support platform type: "${type}
    fi
}
#<}}}

#{{{> choose cpt
function choose_complete_scheme() {
    local srcPath=${PWD}
    local destPath=$HOME
    if [ "$#" = "1" ]; then
        srcPath=${PWD}
        destPath="$1"
    elif [ "$#" = "2" ]; then
        srcPath="$1"
        destPath="$2"
    fi

    opt_print "Complete schemes:" "0. build-in" "1. vimautosense & vimdicts" "2. YouCompleteMe" "3. coc"
    local opt=""
    local defaultOpt=2
    read -n1 -p "Please choose a complete scheme (default ${defaultOpt}):" opt
    if [ -z "${opt}" ]; then
        opt=${defaultOpt}
    fi

    if [ "$(uname)" = "Darwin" ]; then
        if [ "${opt}" = "0" ]; then
            sed -i "" 's/let g:completeScheme=1/let g:completeScheme=0/g' ${destPath}/.vimrc.custom.config
        elif [ "${opt}" = "1" ]; then
            sed -i "" 's/let g:completeScheme=1/let g:completeScheme=1/g' ${destPath}/.vimrc.custom.config
        elif [ "${opt}" = "2" ]; then
            sed -i "" 's/let g:completeScheme=1/let g:completeScheme=2/g' ${destPath}/.vimrc.custom.config
        elif [ "${opt}" = "3" ]; then
            sed -i "" 's/let g:completeScheme=1/let g:completeScheme=3/g' ${destPath}/.vimrc.custom.config
        fi
    elif [ "$(uname)" = "Linux" ]; then
        if [ "${opt}" = "0" ]; then
            sed -i 's/let g:completeScheme=1/let g:completeScheme=0/g' ${destPath}/.vimrc.custom.config
        elif [ "${opt}" = "1" ]; then
            sed -i  's/let g:completeScheme=1/let g:completeScheme=1/g' ${destPath}/.vimrc.custom.config
        elif [ "${opt}" = "2" ]; then
            sed -i 's/let g:completeScheme=1/let g:completeScheme=2/g' ${destPath}/.vimrc.custom.config
        elif [ "${opt}" = "3" ]; then
            sed -i 's/let g:completeScheme=1/let g:completeScheme=3/g' ${destPath}/.vimrc.custom.config
        fi
    else
        color_print "error" "don't support sed"
        exit 1
    fi

    if [ "${opt}" = "3" ]; then
        rm -rf ${destPath}/.vim/coc-settings.json
        cp -rf ${srcPath}/plugin_configuration/coc/coc-settings.json ${destPath}/.vim/coc-settings.json
    fi
}
#<}}}

#{{{> get_complete_scheme
function get_complete_scheme() {
    local srcPath=${PWD}
    local destPath=$HOME
    if [ "$#" = "1" ]; then
        srcPath=${PWD}
        destPath="$1"
    elif [ "$#" = "2" ]; then
        srcPath="$1"
        destPath="$2"
    fi

    if [ -e "${destPath}/.vimrc.custom.config" ]; then
        echo `cat ${destPath}/.vimrc.custom.config | grep "g:completeScheme" | awk -F '=' '{print $2}'`
    else
        echo "not exist ${destPath}/.vimrc.custom.config"
    fi
}
#<}}}


