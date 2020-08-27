let $NVIMRC=fnamemodify(expand('<sfile>'), ':h')
let $CACHE=expand('$HOME/.cache')
exe 'source' $NVIMRC.'/basic.vim'
exe 'source' $NVIMRC.'/plug.vim'
