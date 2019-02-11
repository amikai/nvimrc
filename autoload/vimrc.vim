if exists("g:vimrc")
  finish
endif
let g:vimrc = 1

function! vimrc#show_function_key() abort
    let l:msg =  "<F3> autoformat | ".
                \"<F4> defx | ".
                \"<F5> nerdtree | ".
                \"<F6> undotree | ".
                \"<F8> tagbar | ".
                \"<F12> show msg"
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
