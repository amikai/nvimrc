#!/bin/bash

vimrc_path=$HOME/.config/nvim

set -e

success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ''
    exit
}

install_nvim_folder() {
    [ "$(ls -A $vimrc_path)" ] && fail "$vimrc_path is not empty, please backup or delete it." 
    git clone https://github.com/amikai/nvimrc.git "$vimrc_path/nvimrc"
    cp "$vimrc_path/nvimrc/init.vim" "$vimrc_path/init.vim"
    success "install nvim folder"
}

install_vim_plug() {
    mkdir -p $vimrc_path/nvim/autoload
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    success "install vim-plug"
}

install_vim_plugin() {
    nvim +PlugInstall +qa >/dev/null 2>&1
    success "install vim-plugin"
}

install_nvim_folder
install_vim_plug
install_vim_plugin
