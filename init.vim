if !exists('g:debug_vimrc')
    let $NVIMRC=fnamemodify(expand('<sfile>'), ':h')
    let $CACHE=expand('$HOME/.cache')
    exe 'source' $NVIMRC.'/basic.vim'
    exe 'source' $NVIMRC.'/dein_plug.vim'

    if has('vim_starting') && !empty(argv())
        call vimrc#on_filetype()
    endif

    if !has('vim_starting')
        call dein#call_hook('source')
        call dein#call_hook('post_source')
    endif

    set bg=dark
    colorscheme gruvbox
else
    echom "debug start"
    let $NVIMRC=fnamemodify(expand('<sfile>'), ':h')
    let $CACHE='/tmp'
    exe 'source' $NVIMRC.'/debug_vimrc.vim'
endif

