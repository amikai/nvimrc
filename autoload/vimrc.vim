if exists('g:vimrc')
    finish
endif
let g:vimrc = 1

function! vimrc#show_function_key() abort
    let l:msg =  '<F1> load session | '.
                \'<F2> goyo focus | '.
                \'<F3> autoformat | '.
                \'<F4> defx | '.
                \'<F5> whitespace | '.
                \'<F6> undotree | '.
                \'<F7> ale | '.
                \'<F8> tagbar | '.
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

function! vimrc#close_floating_window() abort
    let l:wins = nvim_list_wins()
    for wid in l:wins
        if !empty(nvim_win_get_config(wid)['relative'])
            call nvim_win_close(wid, 0)
        endif
    endfor
endfunction
