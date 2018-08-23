if exists("g:vimrc")
  finish
endif
let g:vimrc = 1

function! vimrc#colors(colorscheme_name) abort
    " g:colorscheme_bg_list 
    if !has_key(g:colorscheme_bg_list, a:colorscheme_name)
        return
    endif
    exe 'set background='.get(g:colorscheme_bg_list, a:colorscheme_name)
    exe 'colorscheme '.a:colorscheme_name

endfunction

function! vimrc#colors_random() abort
    " all color scheme
    let l:ran_num = str2nr(system('echo -n $RANDOM')) % len(g:colorscheme_bg_list)
    let l:colorscheme_list = keys(g:colorscheme_bg_list)
    let l:final_colorscheme = l:colorscheme_list[l:ran_num]
    call vimrc#colors(l:final_colorscheme)
    echo 'color scheme: '.l:final_colorscheme
endfunction

function! vimrc#show_function_key() abort
    let l:msg =  "<F3> autoformat | ".
                \"<F5> nerdtree | ".
                \"<F6> undotree | ".
                \"<F7> random colorscheme | ".
                \"<F8> tagbar | ".
                \"<F12> show msg"
    echo l:msg
endfunction
