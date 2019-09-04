if exists('g:vimrc')
    finish
endif
let g:vimrc = 1

function! vimrc#show_function_key() abort
    let l:msg =  '<F1> defx | '.
                \'<F2> goyo focus | '.
                \'<F3> autoformat | '.
                \'<F4> load session | '.
                \'<F5> whitespace | '.
                \'<F6> undotree | '.
                \'<F11> tagbar | '.
                \'<F12> show msg'
    echo l:msg
endfunction

function! vimrc#on_filetype() abort
    if execute('filetype') =~# 'OFF'
        " Lazy loading
        silent! filetype plugin indent on
        syntax enable
        filetype detect
    endif
endfunction

function! vimrc#load_session() abort
    let l:session_file = 'Session.vim'
    if filereadable(l:session_file)
        exe "source" l:session_file
    endif
endfunction
