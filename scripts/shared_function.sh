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

#{{{> print PithyVimart logo
function print_logo() {
    local color="$(tput setaf 6)"
    local normal="$(tput sgr0)"
    printf "${color}"
    echo ''
    echo '________ _____ _____ ______           ___    _______                             _____ '
    echo '___  __ \___(_)__  /____  /_ _____  ____ |  / /___(_)_______ ___ ______ ___________  /_'
    echo '__  /_/ /__  / _  __/__  __ \__  / / /__ | / / __  / __  __ `__ \_  __ `/__  ___/_  __/'
    echo '_  ____/ _  /  / /_  _  / / /_  /_/ / __ |/ /  _  /  _  / / / / // /_/ / _  /    / /_  '
    echo '/_/      /_/   \__/  /_/ /_/ _\__, /  _____/   /_/   /_/ /_/ /_/ \__,_/  /_/     \__/  by Qeuroal.'
    echo '                             /____/                                                    '
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

#{{{> config export
function configureTerm() {
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
    if [[ ! -f "${dstpath}" ]]; then
        return
    fi

    if [ `cat ${dstpath} | grep -c "export TERM"` = 1 ]; then
        echo "${dstpath}: `cat ${dstpath} | grep \"export TERM\"`"
    else
        # getting proper colors
        echo "" | tee -a ${dstpath} > /dev/null
        echo '# getting proper colors' | tee -a ${dstpath} > /dev/null
        echo 'export TERM="xterm-256color"' | tee -a ${dstpath} > /dev/null
        echo "" | tee -a ${dstpath} > /dev/null
    fi

}
#<}}}


#{{{> config shell
function configure_shell() {
    configureAliases ".zshrc"
    configureAliases ".bashrc"
    configureAliases ".bash_profile"

    configureEof
    configureTerm ".zshrc"
    configureTerm ".bashrc"
    configureTerm ".bash_profile"
}
#<}}}

#{{{> has sudo
function has_sudo() {
    sudo -v &>/dev/null
    # sudo or root
    if [ $? -ne 0 ] && [ "$(id -u)" != "0" ]; then
        echo 0
    else
        echo 1
    fi
}
#<}}}

