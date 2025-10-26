#!/usr/bin/env bash

source ${PWD}/scripts/color_print.sh

# 判断文件是否存在
function is_exist_file()
{
    filename=$1
    if [ -f $filename ]; then
        echo 1
    else
        echo 0
    fi
}

# 判断目录是否存在
function is_exist_folder()
{
    dir=$1
    if [ -d $dir ]; then
        echo 1
    else
        echo 0
    fi
}

# delete .vim
vimPath=${HOME}"/.vim"
isExist=$(is_exist_folder ${vimPath})
if [ ${isExist} -eq 1 ]; then
    # echo -e "\033[31mRemove ${vimPath}\033[0m"
    color_print "info" "Remove ${vimPath}"

    type=$(uname)
    if [[ ${type} == "Darwin" ]]; then
        sudo rm -rf ${vimPath}
    elif [[ ${type} == "FreeBSD" ]]; then
        # installVimartOnFreebsd
        sudo rm -rf ${vimPath}
    elif [[ ${type} == "Linux" ]]; then
        if [ `groups | grep -c sudo` != 0 ] || [ `groups | grep -c wheel` != 0 ]; then
            sudo rm -rf ${vimPath}
        else
            rm -rf ${vimPath}
        fi
    fi
fi

# delete .viminfo
viminfoPath=${HOME}"/.viminfo"
isExist=$(is_exist_file ${viminfoPath})
if [ ${isExist} -eq 1 ]; then
    # echo -e "\033[31mRemove ${viminfoPath}\033[0m"
    color_print "info" "Remove ${viminfoPath}"
    rm -rf ${viminfoPath}
fi

# delete .vimrc
vimrcPath=${HOME}"/.vimrc"
isExist=$(is_exist_file ${vimrcPath})
if [ ${isExist} -eq 1 ]; then
    # echo -e "\033[31mRemove ${vimrcPath}\033[0m"
    color_print "info" "Remove ${vimrcPath}"
    rm -rf ${vimrcPath}
fi

# delete .vimart
vimartPath=${HOME}"/.vimart"
isExist=$(is_exist_folder ${vimartPath})
if [ ${isExist} -eq 1 ]; then
    # echo -e "\033[31mRemove ${vimartPath}\033[0m"
    color_print "info" "Remove ${vimartPath}"
    rm -rf ${vimartPath}
fi

# delete .vimrc.cpt.config
vimrc_cpt_config_path=${HOME}"/.vimrc.cpt.config"
isExist=$(is_exist_file ${vimrc_cpt_config_path})
if [ ${isExist} -eq 1 ]; then
    # echo -e "\033[31mRemove ${vimrc_cpt_config_path}\033[0m"
    color_print "info" "Remove ${vimrc_cpt_config_path}"
    rm -rf ${vimrc_cpt_config_path}
fi

# delete ycm_extra_conf
ycmExtConfPath=${HOME}"/.ycm_extra_conf.py" 
isExist=$(is_exist_file ${ycmExtConfPath})
if [ ${isExist} -eq 1 ]; then
    # echo "${ycmExtConfPath}"
    # echo -e "\033[31mRemove ${ycmExtConfPath}\033[0m"
    color_print "info" "Remove ${ycmExtConfPath}"
    rm -rf ${ycmExtConfPath}
fi

# delete custom config data
# echo -n -e "\033[32m===> Would you like to remove your custom config? [Y/N]\033[0m"
color_print "opt" "Would you like to remove your custom config? [Y/N]"
choice=n
read -n1 -p "" choice
echo ""
if [[ "${choice}" == 'y' || "${choice}" == 'Y' ]]; then
    # echo -e "\033[31mRemove your custom config\033[0m"
    color_print "info" "Remove your custom config"
    rm -rf ${HOME}"/.vimrc.custom.config" ${HOME}"/.vimrc.custom.plugins"
fi

# echo -e "\033[32m===> Done!!! \033[0m"
color_print "finish" "Done!!! "


