let s:dein_dir = expand('$CACHE/dein')

if &runtimepath !~# '/dein.vim'
    let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
    " Auto Download
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
    endif

    execute 'set runtimepath^=' . s:dein_repo_dir
endif

let g:dein#install_max_processes = 16
let g:dein#install_message_type = 'none'

call dein#begin(s:dein_dir)
    call dein#add('Shougo/dein.vim')
call dein#end()
filetype plugin indent on
syntax enable

if has('vim_starting') && dein#check_install()
    call dein#install()
endif

" vim: set foldmethod=marker tw=80 sw=4 ts=4 sts =4 sta nowrap et :
