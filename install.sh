#!/bin/bash
vimrc_path=$HOME/.config/nvim
current_dir=$(pwd)

bash <(curl -s https://raw.githubusercontent.com/amikai/nvimrc/install/install.sh)
git clone https://github.com/amikai/nvimrc.git
mv $current_dir/../nvimrc $vimrc_path
mv $vimrc_path/nvimrc/init.vim $vimrc_path/init.vim
