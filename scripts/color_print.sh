#!/usr/bin/env bash

function to_upper() {
    echo "$@" | tr '[:lower:]' '[:upper:]'
}

function to_lower() {
    echo "$@" | tr '[:upper:]' '[:lower:]'
}

function color_print() {
    mode="$(to_lower $1)"
    # 左移一位
    shift 1

    # colors
    bg_black="\033[40m"
    bg_red="\033[41m"
    bg_green="\033[42m"
    bg_yellow="\033[43m"
    bg_blue="\033[44m"
    bg_purple="\033[45m"
    bg_cyan="\033[46m"
    bg_white="\033[47m"

    fg_black="\033[30m"
    fg_red="\033[31m"
    fg_green="\033[32m"
    fg_yellow="\033[33m"
    fg_blue="\033[34m"
    fg_purple="\033[35m"
    fg_cyan="\033[36m"
    fg_white="\033[37m"

    color=""
    set_clear="\033[0m"
    set_bold="\033[1m"
    set_underline="\033[4m"
    set_flash="\033[5m"

    case "${mode}" in
        "finish")
            color="${bg_black}${fg_green}"
            ;;
        "begin")
            color="${fg_black}${fg_green}"
            ;;
        "opt")
            color="${fg_black}${fg_yellow}"
            ;;
        "error")
            color="${bg_black}${fg_red}${set_bold}"
            ;;
        "warning")
            color="${bg_yellow}${fg_black}"
            ;;
        "info")
            color="${bg_black}${fg_purple}"
            ;;
        *)
            set_clear=""
            ;;
    esac

    info="${color}==> $@${set_clear}"
    if [[ "${mode}" == "opt" ]]; then
        echo -e -n "${info}"
    else
        echo -e "${info}"
    fi
}

function block_color_print() {
    mode="$(to_lower $1)"
    # 左移一位
    shift 1

    color="$(tput sgr0)"
    normalColor="$(tput sgr0)"

    case "${mode}" in
        "finish")
            # color="${bg_black}${fg_green}"
            color="$(tput setaf 2)"
            ;;
        "begin")
            # color="${fg_black}${fg_green}"
            color="$(tput setaf 2)"
            ;;
        "opt")
            # color="${fg_black}${fg_yellow}"
            color="$(tput setaf 3)"
            ;;
        "error")
            # color="${bg_black}${fg_red}${set_bold}"
            color="$(tput setaf 1 bold)"
            ;;
        "warning")
            # color="${bg_yellow}${fg_black}"
            color="$(tput setab 3 setaf 0)"
            ;;
        "info")
            # color="${bg_black}${fg_purple}"
            color="$(tput setaf 5)"
            ;;
        *)
            ;;
    esac

    echo "${color}"

    if [[ "${mode}" == "opt" ]]; then
        echo "==> $1"
        shift 1
    else
        # echo "==> $(echo "${mode}" | tr '[:lower:]' '[:upper:]') {{{"
        echo "==> $(to_upper "${mode}") {{{"
    fi

    while [[ $# -ne 0 ]]
    do
        echo "  $1"
        shift 1
    done

    if [[ "${mode}" == "opt" ]]; then
        printf "${normalColor}"
    else
        echo "<=== }}}${normalColor}"
        echo ''
    fi
}

function opt_print() {
    opt="$1"
    val="$2"
    
    if [[ -z ${opt}  ]]; then
        return
    elif [[ ${#opt} -le 24 ]]; then
        printf "  %-24s%-s\n" "${opt}" "${val}"
    else
        printf "  %-24s\n    %24s%s\n" "${opt}" " " "${val}"
    fi
    
    if [[ $# -ge 2 ]]; then
        shift 2
    fi

    while [ $# -ne 0 ]
    do
        printf "    %24s%s\n" " " "$1"
        shift
    done
}
