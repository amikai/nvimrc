" Thanks https://github.com/rafi/vim-config/blob/master/config/plugins/deoplete.vim



" Gerneral settings "{{{

call deoplete#custom#option({
            \ 'auto_complete_delay': 700,
            \ 'ignore_case': v:false,
            \ 'auto_complete': v:true,
            \ 'refresh_always': v:true
            \ })

autocmd MyAutoCmd CompleteDone * silent! pclose!
" }}}

" Matchers and Conveters "{{{

call deoplete#custom#source('_', 'converters', [
            \ 'converter_auto_paren',
            \ 'converter_remove_overlap',
            \ 'converter_truncate_abbr',
            \ 'converter_truncate_menu',
            \ 'converter_auto_delimiter',
            \ ])

call deoplete#custom#source('_', 'matchers', ['matcher_head'])
call deoplete#custom#source('_', 'sorters', ['sorter_rank'])
" }}}

" Sources setting "{{{

" Disable the candidates in Comment/String syntaxes.
" call deoplete#custom#source('_',
"             \ 'disabled_syntaxes', ['Comment', 'String'])

" Use mathcer_head instead of fuzzy

call deoplete#custom#option('sources', {
            \ '_': ['around','buffer', 'tabnine'],
            \ 'c': ['buffer', 'tag', 'member'],
            \ 'vim': ['vim','buffer'],
            \ 'rust': ['racer', 'buffer', 'member'],
            \ 'python' :['jedi', 'buffer', 'member', 'file'],
            \ 'php' :['phpactor', 'buffer', 'member', 'file'],
            \ 'javascript': ['omni','tern'],
            \})

call deoplete#custom#var('omni', 'input_patterns', {
            \ 'javascript': '[^. *\t]\.\w*'
            \})

call deoplete#custom#source('omni', 'functions', {
            \ 'javascript': ['jspc#omni'],
            \})

call deoplete#custom#source('buffer',
            \ 'max_candidates', 10)

call deoplete#custom#source('around',
            \ 'max_candidates', 10)

call deoplete#custom#source('tabnine',
            \ 'max_candidates', 10)

call deoplete#custom#source('neosnippet',
            \ 'max_candidates', 10)

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
call deoplete#custom#source('tern', 'mark', '⚡')
call deoplete#custom#source('syntax', 'mark', '♯')

" }}}

" Key mapping "{{{
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
imap <silent><expr><CR> pumvisible() ?
            \ (neosnippet#expandable() ? neosnippet#mappings#expand_impl() : deoplete#close_popup())
            \:(dein#is_sourced('delimitMate') ?  "<Plug>delimitMateCR" : "\<cr>")
inoremap <expr><C-f> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr><C-b> pumvisible() ? "\<PageUp>" : "\<Left>"

" }}}

" Language specific setting {{{
autocmd FileType go call <SID>golang_setting()
function! s:golang_setting() abort

    call deoplete#custom#option('sources', {
                \ 'go' :['omni', 'buffer', 'member', 'file', 'neosnippet']
                \})

    call deoplete#custom#var('omni', 'input_patterns', {
                \ 'go' : '[^. *\t]\.\w*'
                \})
    call deoplete#custom#source('omni', 'functions', {
                \ 'go': ['go', 'go#complete#Complete'],
                \})

    call deoplete#custom#source('omni',
                \ {'max_candidates': 5,
                \  'rank':900
                \ })

    call deoplete#custom#source('tabnine',
                \ {'max_candidates': 3,
                \  'rank':800
                \ })

    call deoplete#custom#source('neosnippet',
                \ {'max_candidates': 3,
                \  'rank':700
                \ })

    call deoplete#custom#source('buffer',
                \ {'max_candidates': 3,
                \  'rank':600
                \ })

    call deoplete#custom#source('arround',
                \ {'max_candidates': 3,
                \  'rank':600
                \ })

    "" deoplete use vim-go omnifunc to complete
endfunction
" }}}

" vim: set foldmethod=marker tw=80 sw=4 ts=4 sts =4 sta nowrap et :
