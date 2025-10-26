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

function import_gitconfig ()
{
    if [ $# -ne 1 ]; then
        color_print "error" "parameter error: expect 1 parameters."
        return
    fi
    local destfilepath="$1"

    echo '[include]' | tee -a ${destfilepath} > /dev/null
    echo '	path = ~/.config/pithy_configs/.gitconfig' | tee -a ${destfilepath} > /dev/null
    color_print "info" "Success to import configure to $destfilepath"
}

function selfimport_sshconfig ()
{
    if [ $# -ne 1 ]; then
        color_print "error" "parameter error: expect 1 parameters."
        return
    fi
    local destfilepath="$1"
    [ ! -e "$destfilepath" ] && echo '' >> $destfilepath

    if [[ "$(is_gnu_sed)" -eq 1 ]]; then
        if [[ ! -e "$destfilepath.default.bak" ]]; then
            sed -i.default.bak -e '1i\# import sshconfig' -e '1i\Include ~/.config/pithy_configs/.sshconfig' -e '1{x;p;x;}' $destfilepath
        else
            sed -i.sed.bak -e '1i\# import sshconfig' -e '1i\Include ~/.config/pithy_configs/.sshconfig' -e '1{x;p;x;}' $destfilepath
        fi
        color_print "info" "Success to import configure to $destfilepath"
    else
        echo 'Include ~/.config/pithy_configs/.sshconfig' | tee -a ${destfilepath} > /dev/null
        color_print "warning" "WARNING: The .ssh/config configuration should be placed at the beginning of the file."
        color_print "info" "HALF success to import configure to $destfilepath"
    fi
}

function import_tmux_conf ()
{
    if [ $# -ne 1 ]; then
        color_print "error" "parameter error: expect 1 parameters."
        return
    fi
    local destfilepath="$1"

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
        # selfimport_* 函数自行导入 import signal
        [[ ! "$hook_func" =~ "selfimport_" ]] && echo '' | tee -a ${destfilepath} > /dev/null; echo "$import_signal" | tee -a ${destfilepath} > /dev/null
        $hook_func ${destfilepath}
        return 0
    fi

    return 2
}

function main ()
{
    import_configure "$HOME/.gitconfig" "; import gitconfig" "import_gitconfig"
    import_configure "$HOME/.ssh/config" "# import sshconfig" "selfimport_sshconfig"
    import_configure "$HOME/.tmux.conf" "# import tmux.conf" "import_tmux_conf"

    return 0
}

main
