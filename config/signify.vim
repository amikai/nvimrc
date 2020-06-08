let g:signify_skip_filetype = { 'defx': 1, 'tagbar': 1 }
function! SignifySetting() abort
    autocmd Filetype * call s:skip_ft_keymapping()
endfunction

function! s:skip_ft_keymapping() abort
    let l:skip_fts = keys(filter(copy(g:signify_skip_filetype), 'v:val == 1'))
    for skip_ft in l:skip_fts
        if &ft == skip_ft
            " do nothing
            return 
        endif
    endfor
    call s:keymapping()
endfunction

function! s:keymapping() abort
    xmap <buffer> ic <plug>(signify-motion-inner-visual)
    nmap <buffer> [c <plug>(signify-next-hunk)
    nmap <buffer> ]c <plug>(signify-prev-hunk)
    omap <buffer> ic <plug>(signify-motion-inner-pending)
    omap <buffer> ac <plug>(signify-motion-outer-pending)
    xmap <buffer> ac <plug>(signify-motion-outer-visual)
endfunction

call SignifySetting()
