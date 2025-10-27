#!/usr/bin/env bash

source ${PWD}/scripts/color_print.sh

function is_gnu_sed() {
    if ! command -v sed > /dev/null; then
        echo 0
    elif [[ "$(uname)" == 'Darwin' && "$(command -v sed | grep -c 'gnu-sed')" -eq 0 ]]; then
        echo 0
    else
        echo 1
    fi
}

function sed_improt_prelude ()
{
    if [ $# -ne 3 ]; then
        color_print "error" "parameter error: expect 1 parameters."
        return
    fi
    local destfilepath="$1"
    local import_signal="$2"
    local import_content="$3"

    [ ! -e "$destfilepath" ] && echo '' >> $destfilepath
    if [[ "$(is_gnu_sed)" -eq 1 ]]; then
        if [[ ! -e "$destfilepath.default.bak" ]]; then
            # 添加空行使用 -e '1{x;p;x;}'
            sed -i.default.bak -e "1i\\$import_signal" -e "1i$import_content" $destfilepath
        else
            sed -i.sed.bak -e "1i\\$import_signal" -e "1i$import_content" $destfilepath
        fi
        color_print "info" "Success to import configure to $destfilepath"
    else
        echo "$import_content" | tee -a ${destfilepath} > /dev/null
        color_print "warning" "WARNING: The $destfilepath configuration should be placed at the beginning of the file."
        color_print "info" "HALF success to import configure to $destfilepath"
    fi

}

function preimport_gitconfig ()
{
    if [ $# -ne 2 ]; then
        color_print "error" "parameter error: expect 1 parameters."
        return
    fi
    local destfilepath="$1"
    local import_signal="$2"

    sed_improt_prelude "$destfilepath" "$import_signal" '[include]\n	path = ~/.config/pithy_configs/.gitconfig'

    # echo '[include]\n	path = ~/.config/pithy_configs/.gitconfig' | tee -a ${destfilepath} > /dev/null
    # echo '' | tee -a ${destfilepath} > /dev/null
    # color_print "info" "Success to import configure to $destfilepath"
}

function preimport_sshconfig ()
{
    if [ $# -ne 2 ]; then
        color_print "error" "parameter error: expect 1 parameters."
        return
    fi
    local destfilepath="$1"
    local import_signal="$2"

    sed_improt_prelude "$destfilepath" "$import_signal" 'Include ~/.config/pithy_configs/.sshconfig\n'
}

function import_tmux_conf ()
{
    if [ $# -ne 1 ]; then
        color_print "error" "parameter error: expect 1 parameters."
        return
    fi
    local destfilepath="$1"
    local import_signal="$2"

    echo 'source-file ~/.config/pithy_configs/.tmux.conf' | tee -a ${destfilepath} > /dev/null
    color_print "info" "Success to import configure to $destfilepath"
}

function import_configure ()
{
    local destfilepath=""
    local import_signal=""
    local hook_func=""

    if [ $# -eq 3 ]; then
        destfilepath="$1"
        import_signal="$2"
        hook_func="$3"
    else
        color_print "error" "parameter error: expect 3 parameters."
        return
    fi

    [ ! -f ${destfilepath} ] && touch ${destfilepath}

    if [ `cat ${destfilepath} | grep -c "$import_signal"` = 0 ]; then
        # preimport_* 函数自行导入 import signal
        [[ ! "$hook_func" =~ "preimport_" ]] && (echo '' | tee -a ${destfilepath} > /dev/null; echo "$import_signal" | tee -a ${destfilepath} > /dev/null)
        $hook_func "${destfilepath}" "${import_signal}"
        return 0
    fi

    return 2
}

function main ()
{
    import_configure "$HOME/.gitconfig" "; import gitconfig" "preimport_gitconfig"
    import_configure "$HOME/.ssh/config" "# import sshconfig" "preimport_sshconfig"
    import_configure "$HOME/.tmux.conf" "# import tmux.conf" "import_tmux_conf"

    return 0
}

main
