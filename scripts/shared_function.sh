#!/usr/bin/env bash

PITHY_CONFIG_PATH="$HOME/.config/pithy_configs"

#{{{> backup personal vim configure
function backup_vim_data() {
    # echo -e "\033[32m==> Backuping vim data...\033[0m"
    color_print "info" "Backuping vim data..."
}
#<}}}

#{{{> copy and link files
function copy_files() {
    # echo -e "\033[32m==> Copying files...\033[0m"
    color_print "info" "Copying files..."

    local srcpath=${PWD}
    local destpath=$HOME
    if [ "$#" = "1" ]; then
        srcpath=${PWD}
        destpath="$1"
    elif [ "$#" = "2" ]; then
        srcpath="$1"
        destpath="$2"
    fi

    color_print "info" "srcpath: $srcpath"
    color_print "info" "destfilepath: $destpath"

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

#{{{> configure shell_config
function configure_shell_config() {
    local destFile=".zshrc"
    local srcpath=${PWD}
    local destpath=$HOME
    if [ "$#" = "1" ]; then
        destFile="$1"
    elif [ "$#" = "2" ]; then
        destFile="$1"
        destpath="$2"
    elif [ "$#" = "3" ]; then
        destFile="$1"
        srcpath="$2"
        destpath="$3"
    fi

    local destfilepath="${destpath}/${destFile}"

    if [ ! -e "${PITHY_CONFIG_PATH}/.shell_config" ]; then
        color_print "warning" "File .shell_config does not exist."
        return
    fi

    if [[ -f "${destfilepath}" ]]; then
        if [[ `cat ${destfilepath} | grep -c '# import shell_config'` = 0 ]]; then
            echo "" | tee -a ${destfilepath} > /dev/null
            echo '# import shell_config' | tee -a ${destfilepath} > /dev/null
            # echo 'if [[ -f ~/.shell_config ]]; then {source ~/.shell_config}; fi'
            echo "[[ -e ${PITHY_CONFIG_PATH}/.shell_config ]] && source ${PITHY_CONFIG_PATH}/.shell_config" | tee -a ${destfilepath} > /dev/null
        fi
    fi
}
#<}}}

#{{{> link dotfiles
function link_dotfiles() {
    if [ -d "$PITHY_CONFIG_PATH" ]; then
        if [ -L "$PITHY_CONFIG_PATH" ]; then
            unlink $PITHY_CONFIG_PATH
        else
            mv $PITHY_CONFIG_PATH $PITHY_CONFIG_PATH.bak
        fi
    elif [ -e "$PITHY_CONFIG_PATH" ]; then
        mv $PITHY_CONFIG_PATH $PITHY_CONFIG_PATH.bak
    fi

    if [ ! -d "$HOME/.config" ]; then
        mkdir -p "$HOME/.config"
    fi

    color_print "info" "ln -sf `realpath $PWD/assets/dotfiles` $PITHY_CONFIG_PATH"
    ln -sf `realpath $PWD/assets/dotfiles` $PITHY_CONFIG_PATH
}
#<}}}

#{{{> config shell
function configure_shell() {
    configure_shell_config ".zshrc"
    configure_shell_config ".bashrc"
    configure_shell_config ".bash_profile"
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

