if exists("g:vimrc")
  finish
endif
let g:vimrc = 1

function! vimrc#colors(scheme) abort
    " the colorscheme need to set background
    let l:schemes_list = {'gruvbox':'dark', 'one':'light', 'hybird_reverse':'dark',
                \ 'hybrid_material': 'dark'}
    if has_key(l:schemes_list, a:scheme)
        exe "set background=".l:schemes_list[a:scheme]
    else
        exe "set background=dark"
    endif
    exe "colorscheme ".a:scheme
endfunction

function! vimrc#colors_random() abort
    " all color scheme
    let l:schemes_list = map(split(globpath(&rtp, "colors/*.vim"),'\n'),
        \ {index,val -> fnamemodify(val, ":t:r")})
    let l:ran = str2nr(system('echo -n $RANDOM')) % len(l:schemes_list)
    call vimrc#colors(l:schemes_list[l:ran])
    echo 'color scheme: '.l:schemes_list[l:ran]
endfunction
