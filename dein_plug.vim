let s:dein_dir = expand($nvimrc.'/dein')

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

if !dein#load_state(s:dein_dir)
    finish
endif

call dein#begin(s:dein_dir, expand('<sfile>'))
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif
    call dein#load_toml(expand($nvimrc.'/plugins.toml'), {'lazy': 0})
    call dein#load_toml(expand($nvimrc.'/plugins_lazy.toml'), {'lazy': 1})
call dein#end()
call dein#save_state()

if has('vim_starting') && dein#check_install()
    call dein#install()
endif
" vim: set foldmethod=marker tw=80 sw=4 ts=4 sts =4 sta nowrap et :
