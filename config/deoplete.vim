" Thanks https://github.com/rafi/vim-config/blob/master/config/plugins/deoplete.vim



" Gerneral settings "{{{

call deoplete#custom#option({
            \ 'auto_complete_delay': 200,
            \ 'ignore_case': v:false,
            \ 'auto_complete': v:false,
            \ 'refresh_always': v:true
            \ })

autocmd MyAutoCmd CompleteDone * silent! pclose!
" }}}

" Matchers and Conveters "{{{ 

call deoplete#custom#source('_', 'converters', [
            \ 'converter_remove_paren',
            \ 'converter_remove_overlap',
            \ 'converter_truncate_abbr',
            \ 'converter_truncate_menu',
            \ 'converter_auto_delimiter',
            \ ])

call deoplete#custom#source('_', 'matchers', ['matcher_head'])
" }}}

" Sources setting "{{{

" Disable the candidates in Comment/String syntaxes.
" call deoplete#custom#source('_',
"             \ 'disabled_syntaxes', ['Comment', 'String'])

" Use mathcer_head instead of fuzzy

call deoplete#custom#option('sources', {
            \ '_': ['around','buffer', 'syntax'],
            \ 'c': ['buffer', 'tag', 'member'],
            \ 'vim': ['vim','buffer'],
            \ 'rust': ['racer', 'buffer', 'member'],
            \ 'go' :['omni', 'buffer', 'member', 'file'],
            \ 'python' :['jedi', 'buffer', 'member', 'file'],
            \ 'php' :['phpactor', 'buffer', 'member', 'file'],
            \})

call deoplete#custom#var('omni', 'input_patterns', {
            \ 'go' : '[^.[:digit:] *\t]\.'
            \})

call deoplete#custom#source('omni', 'functions', {
            \ 'go':  'go#complete#Complete'
            \})

" Change the source mark
call deoplete#custom#source('buffer', 'mark', 'buf')
call deoplete#custom#source('file', 'mark', '📄 ')
call deoplete#custom#source('tag', 'mark', '⌦')
call deoplete#custom#source('omni', 'mark', '⊙')
call deoplete#custom#source('member', 'mark', '∙')
call deoplete#custom#source('around', 'mark', '↺')

call deoplete#custom#source('neosnippet',    'mark', '⌘')
call deoplete#custom#source('racer', 'mark', '⚡')
call deoplete#custom#source('jedi', 'mark', '⚡')
call deoplete#custom#source('phpactor', 'mark', '⚡')
call deoplete#custom#source('vim', 'mark', '⚡')
call deoplete#custom#source('syntax', 'mark', '♯')

" }}}

" Key mapping "{{{
inoremap <expr><C-g>       deoplete#refresh()
inoremap <expr><C-l> deoplete#complete_common_string()
inoremap <expr><C-e>       deoplete#cancel_popup()
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
" <Tab> completion:
" 1. If popup menu is visible, select and insert next item
" 2. Otherwise, if within a snippet, jump to next input
" 3. Otherwise, if preceding chars are whitespace, insert tab char
" 4. Otherwise, start manual autocomplete
imap <silent><expr><Tab> pumvisible() ? "\<Down>"
            \ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
            \ : (<SID>is_whitespace() ? "\<Tab>"
            \ : deoplete#manual_complete()))

smap <silent><expr><Tab> pumvisible() ? "\<Down>"
            \ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
            \ : (<SID>is_whitespace() ? "\<Tab>"
            \ : deoplete#manual_complete()))

inoremap <expr><S-Tab>  pumvisible() ? "\<Up>" : "\<C-h>"

function! s:is_whitespace()
    let col = col('.') - 1
    return ! col || getline('.')[col - 1] =~? '\s'
endfunction


" <CR>: If popup menu visible, expand snippet or close popup with selection
inoremap <silent><expr><CR> pumvisible() ?
            \ (neosnippet#expandable() ? neosnippet#mappings#expand_impl() : deoplete#close_popup())
            \ : "\<CR>"
inoremap <expr><C-f> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr><C-b> pumvisible() ? "\<PageUp>" : "\<Left>"

" }}}


" vim: set foldmethod=marker tw=80 sw=4 ts=4 sts =4 sta nowrap et :
