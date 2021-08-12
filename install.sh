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
    [ "$(ls -A $vimrc_path)" ] && fail "$vimrc_path is exist, please backup and delete it."
    git clone https://github.com/amikai/nvimrc.git "$vimrc_path"
    success "install nvim folder"
}

install_plugin() {
    nvim +qa
    nvim +checkhealth +"PackerSync" +qa
    success "install plugin"
}

install_nvim_folder
install_plugin
