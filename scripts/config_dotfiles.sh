#!/usr/bin/env bash

source ${PWD}/scripts/color_print.sh

function import_gitconfig ()
{
    if [ $# -ne 1 ]; then
        color_print "error" "parameter error: expect 1 parameters."
        return
    fi
    local destfilepath="$1"
    color_print "info" "Success to import configure to $destfilepath"
    echo '[include]' | tee -a ${destfilepath} > /dev/null
    echo '	path = ~/.config/pithy_configs/.gitconfig' | tee -a ${destfilepath} > /dev/null
}

function import_sshconfig ()
{
    if [ $# -ne 1 ]; then
        color_print "error" "parameter error: expect 1 parameters."
        return
    fi
    local destfilepath="$1"
    color_print "info" "Success to import configure to $destfilepath"

    echo 'Include ~/.config/pithy_configs/.sshconfig' | tee -a ${destfilepath} > /dev/null
}

function import_tmux_conf ()
{
    if [ $# -ne 1 ]; then
        color_print "error" "parameter error: expect 1 parameters."
        return
    fi
    local destfilepath="$1"
    color_print "info" "Success to import configure to $destfilepath"

    echo 'source-file ~/.config/pithy_configs/.tmux.conf' | tee -a ${destfilepath} > /dev/null
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
        echo "$import_signal" | tee -a ${destfilepath} > /dev/null
        $hook_func ${destfilepath}
        return 0
    fi

    return 2
}

function main ()
{
    import_configure "$HOME/.gitconfig" "; import gitconfig" "import_gitconfig"
    import_configure "$HOME/.ssh/config" "# import sshconfig" "import_sshconfig"
    [ "$?" = "0" ] && color_print "warning" "WARNING: The .ssh/config configuration should be placed at the beginning of the file."
    import_configure "$HOME/.tmux.conf" "# import tmux.conf" "import_tmux_conf"

    return 0
}

main
