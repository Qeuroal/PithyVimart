#!/usr/bin/env bash

source ${PWD}/scripts/prints.sh

PITHY_CONFIG_PATH="$HOME/.config/pithy_configs"

function is_gnu_sed() {
  if ! command -v sed &> /dev/null; then
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
      clprint "error" "parameter error: expect 1 parameters."
      return
    fi
    local destfilepath="$1"
    local import_signal="$2"
    local import_content="$3"

    if [[ "$(is_gnu_sed)" -eq 1 ]]; then
      if [[ ! -e "$destfilepath.default.bak" ]]; then
        # 添加空行使用 -e '1{x;p;x;}'
        sed -i.default.bak -e "1i\\$import_signal" -e "1i$import_content" $destfilepath
      else
        sed -i.sed.bak -e "1i\\$import_signal" -e "1i$import_content" $destfilepath
      fi
      clprint "info" "Success to import configure to $destfilepath"
    else
      echo "$import_content" | tee -a ${destfilepath} > /dev/null
      clprint "warning" "WARNING: The $destfilepath configuration should be placed at the beginning of the file."
      clprint "info" "HALF success to import configure to $destfilepath"
    fi

  }

function preimport_gitconfig ()
  {
    if [ $# -ne 2 ]; then
      clprint "error" "parameter error: expect 1 parameters."
      return
    fi
    local destfilepath="$1"
    local import_signal="$2"

    sed_improt_prelude "$destfilepath" "$import_signal" '[include]\n	path = ~/.config/pithy_configs/.gitconfig'
  }

function preimport_sshconfig ()
  {
    if [ $# -ne 2 ]; then
      clprint "error" "parameter error: expect 1 parameters."
      return
    fi
    local destfilepath="$1"
    local import_signal="$2"

    sed_improt_prelude "$destfilepath" "$import_signal" 'Include ~/.config/pithy_configs/.sshconfig\n'
  }

function import_tmux_conf ()
  {
    if [ $# -ne 2 ]; then
      clprint "error" "parameter error: expect 1 parameters."
      return
    fi
    local destfilepath="$1"
    local import_signal="$2"

    echo 'source-file ~/.config/pithy_configs/.tmux.conf' | tee -a ${destfilepath} > /dev/null
    clprint "info" "Success to import configure to $destfilepath"
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
      clprint "error" "parameter error: expect 3 parameters."
      return
    fi

    if [[ ! -e "${destfilepath}" ]]; then
      mkdir -p $(dirname ${destfilepath})
      echo '' >> ${destfilepath}
    elif [[ -d "${destfilepath}" ]]; then
      clprint "error" "The ${destfilepath} is directory."
      return
    fi

    if [ `cat ${destfilepath} | grep -c "$import_signal"` = 0 ]; then
      # preimport_* 函数自行导入 import signal
      [[ ! "$hook_func" =~ "preimport_" ]] && (echo '' | tee -a ${destfilepath} > /dev/null; echo "$import_signal" | tee -a ${destfilepath} > /dev/null)
      $hook_func "${destfilepath}" "${import_signal}"
      return 0
    fi

    return 2
  }

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
    clprint "warning" "File .shell_config does not exist."
    return
  fi

  if [[ -f "${destfilepath}" ]]; then
    if [[ `cat ${destfilepath} | grep -c '# import shell_config'` = 0 ]]; then
      echo "" | tee -a ${destfilepath} > /dev/null
      echo '# import shell_config' | tee -a ${destfilepath} > /dev/null
      # echo 'if [[ -f ~/.shell_config ]]; then {source ~/.shell_config}; fi'
      echo "[[ -e ${PITHY_CONFIG_PATH}/.shell_config ]] && source ${PITHY_CONFIG_PATH}/.shell_config" | tee -a ${destfilepath} > /dev/null

      clprint "info" "Success to import configure to $destfilepath"
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

  clprint "info" "ln -sf `realpath $PWD/assets/dotfiles` $PITHY_CONFIG_PATH"
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

function main () {
  import_configure "$HOME/.gitconfig" "# import gitconfig" "preimport_gitconfig"
  import_configure "$HOME/.ssh/config" "# import sshconfig" "preimport_sshconfig"
  import_configure "$HOME/.tmux.conf" "# import tmux.conf" "import_tmux_conf"

  link_dotfiles
  configure_shell

  return 0
}

main
