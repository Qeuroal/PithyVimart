#!/bin/bash

cd ${HOME}
mkdir temp
tar -zxvf vim_empty.tar.gz -C ./temp/
rm -rf .vim_local
mv ./temp/.vim/ ./.vim_local
rm -rf .vim
ln -s ${HOME}/.vim_local ${HOME}/.vim
# 安装 ycm
cd .vim/plugged/YouCompleteMe/
# python3 ./install.py --all --verbose
python3 ./install.py --all
cd ${HOME}
