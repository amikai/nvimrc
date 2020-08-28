autocmd MyAutoCmd CompleteDone * silent! pclose!

function! s:is_whitespace()
    let col = col('.') - 1
    return ! col || getline('.')[col - 1] =~? '\s'
endfunction

imap <silent><expr><Tab> pumvisible() ? "\<C-n>"
            \ : (vsnip#jumpable(1)  ? "\<Plug>(vsnip-jump-next)"
            \ : (<SID>is_whitespace() ? "\<Tab>"
            \ : completion#trigger_completion()))


smap <silent><expr><Tab> pumvisible() ? "\<C-n>"
            \ : (vsnip#jumpable(1)  ? "\<Plug>(vsnip-jump-next)"
            \ : (<SID>is_whitespace() ? "\<Tab>"
            \ : completion#trigger_completion()))


imap <expr> <cr>  pumvisible() ? (complete_info()["selected"] != "-1" ? 
                 \ "\<Plug>(completion_confirm_completion)" : "\<c-e>\<CR>")
                 \ : (delimitMate#WithinEmptyPair() ?
                 \ "\<C-R>=delimitMate#ExpandReturn()\<CR>" : "\<CR>")

imap <S-Tab> <Plug>(completion_next_source)
