#!/bin/bash
vimrc_path=$HOME/.config/nvim
current_dir=$(pwd)

git clone https://github.com/amikai/nvimrc.git
mv $current_dir/nvimrc $vimrc_path/nvimrc
cp $vimrc_path/nvimrc/init.vim $vimrc_path/init.vim
