function! s:is_whitespace()
    let col = col('.') - 1
    return ! col || getline('.')[col - 1] =~? '\s'
endfunction

imap <silent><expr><Tab> pumvisible() ? "\<C-n>"
            \ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
            \ : (<SID>is_whitespace() ? "\<Tab>"
            \ : '<Plug>(ncm2_manual_trigger)'))

smap <silent><expr><Tab> pumvisible() ? "\<C-n>"
            \ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
            \ : (<SID>is_whitespace() ? "\<Tab>"
            \ : '<Plug>(ncm2_manual_trigger)'))


inoremap <silent><expr><CR> pumvisible() ? (ncm2_neosnippet#completed_is_snippet()
            \ ? ncm2_neosnippet#expand_or("\<CR>", 'im') : "\<c-y>")
	        \ : (dein#tap('delimitMate') && delimitMate#WithinEmptyPair() ?
	        \ "\<C-R>=delimitMate#ExpandReturn()\<CR>" : "\<CR>")
