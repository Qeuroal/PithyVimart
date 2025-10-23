#!/usr/bin/env bash

# {{{> source scripts
source ${PWD}/scripts/color_print.sh
source ${PWD}/scripts/shared_function.sh
source ${PWD}/scripts/install_function_on_mac.sh
source ${PWD}/scripts/install_function_on_linux.sh
# <}}}

function main() {
    # 获取时间
    begin=`get_now_timestamp`
    # 平台类型
    type=$(uname)
    echo "Platform type: "${type}


    if [[ ${type} == "Darwin" ]]; then
        install_vimart_on_mac
    elif [[ ${type} == "FreeBSD" ]]; then
        # installVimartOnFreebsd
        echo "Not support now!!!"
    elif [[ ${type} == "Linux" ]]; then
        tp=$(uname -a)
        if [[ $tp =~ "Android" ]]; then
            echo "Android isn't suppoted now!!!"
            # installVimartOnAndroid
        else
            install_vimart_on_linux
        fi
    else
        echo "Not support platform type: "${type}
    fi

    # 结束时间
    end=`get_now_timestamp`
    # 共运行时间
    second=`expr ${end} - ${begin}`
    min=`expr ${second} / 60`
    echo "It takes "${min}" minutes."
}

main





