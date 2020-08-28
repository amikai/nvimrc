let s:plug_dir = expand('$CACHE/plug')

if &runtimepath !~# '/vim-plug'
    let s:plug_repo_dir = s:plug_dir . '/vim-plug'
    let s:plug_path = s:plug_repo_dir . '/autoload/plug.vim'

    " Auto Download
    if !isdirectory(s:plug_repo_dir)
        execute '!curl -fLo ' . s:plug_path . ' --create-dirs '
                    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif

    execute 'set runtimepath^=' . s:plug_repo_dir
endif


call plug#begin(s:plug_dir)
" rainbow (rainbow parenthethese) {{{
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
" }}}

" vim-cursorword {{{
Plug 'itchyny/vim-cursorword'
" }}}

" indent line guide {{{
Plug 'Yggdroot/indentLine'
let g:indentLine_fileTypeExclude = ['nerdtree', 'diff', 'tagbar', 'help']
" }}}

" vim text object {{{
Plug 'kana/vim-textobj-user'

Plug 'glts/vim-textobj-comment'

Plug 'sgur/vim-textobj-parameter'
" }}}

" vim operator {{{
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
map R <Plug>(operator-replace)
" }}}

" matchup (% enhancement) {{{
Plug 'andymass/vim-matchup'

let g:matchup_matchparen_enabled = 1
let g:matchup_surround_enabled = 1
let g:matchup_matchparen_offscreen = {'method': 'popup'}
let g:matchup_transmute_enabled = 1
let g:matchup_matchpref = {
            \ 'html': { 'tagnameonly': 1}
            \ }
" }}}

" vim-commentary {{{
Plug 'tpope/vim-commentary'
" }}}

" vim dispatch (async build and test) {{{
Plug 'tpope/vim-dispatch'
" }}}

" vim-unimpaired (pairs of handy bracket mappings) {{{
Plug 'tpope/vim-unimpaired'
" }}}

" vim-fugitive (git wrapper) {{{
Plug 'tpope/vim-fugitive'
" }}}

" fzf fuzzy finder {{{
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
exe 'source' $NVIMRC.'/config/fzf.vim'
" }}}

" vim-go {{{
Plug 'fatih/vim-go',{'for':'go', 'do': ':GoUpdateBinaries'}
let g:go_def_mapping_enabled = 0
autocmd Filetype go nmap <buffer> gd <Plug>(go-def)
autocmd Filetype go nmap <buffer> gD <Plug>(go-describe)
autocmd Filetype go nmap <buffer> gR <Plug>(go-rename)
autocmd Filetype go nmap <buffer> gr <Plug>(go-referrers)
autocmd Filetype go nmap <buffer> <leader>gm <Plug>(go-metalinter)


let g:go_metalinter_command = "golangci-lint"
let g:go_metalinter_enabled = ['vet', 'errcheck', 'staticcheck', 'gosimple']
let g:go_metalinter_autosave_enabled = ['vet', 'errcheck', 'staticcheck', 'gosimple']
let g:go_metalinter_autosave = 0
let g:go_jump_to_error = 0

let g:go_echo_go_info = 0
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_guru_scope = ["..."]

autocmd Filetype go nnoremap <buffer> <f16> <cmd>GoTest<cr>
autocmd Filetype go nnoremap <buffer> <f17> <cmd>GoBuild<cr>
autocmd Filetype go nnoremap <buffer> <f18> <cmd>GoRun<cr>

let g:go_highlight_function_calls = 1
" }}}

" rust {{{
Plug 'rust-lang/rust.vim',{'for':'rust'}
let $RUST_SRC_PATH =
            \ system('echo -n "$(rustc --print sysroot)"').
            \ "/lib/rustlib/src/rust/src"

Plug 'racer-rust/vim-racer',{'for': 'rust'}
let g:racer_cmd = system('echo -n "$(which racer)"')
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
" }}}

" js, ts {{{
Plug 'mhartington/nvim-typescript',{'do':'./install.sh', 'for': ['javacript', 'typescript']}
let g:nvim_typescript#server_path = 'tsserver'
let g:nvim_typescript#javascript_support = 1
let g:nvim_typescript#type_info_on_hold = 1
" }}}

" completion nvim {{{
Plug 'nvim-lua/completion-nvim'
let g:completion_auto_change_source = 1
let g:completion_enable_auto_popup = 0
let g:completion_enable_auto_signature = 1
let g:completion_timer_cycle = 200
let g:completion_matching_strategy_list = ['exact']
let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_chain_complete_list = [
            \{'complete_items': ['lsp', 'snippet']},
            \{'complete_items': ['buffers']},
            \]

Plug 'steelsojka/completion-buffers'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
let g:vsnip_snippet_dir = $NVIMRC.'/vsnippets'
" }}}

" nvim-lsp plugin {{{
Plug 'neovim/nvim-lsp'

Plug 'nvim-lua/diagnostic-nvim'
let g:diagnostic_show_sign = 1
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_insert_delay = 1
let g:diagnostic_virtual_text_prefix = '<'
nnoremap <leader>d <cmd>OpenDiagnostic<cr>
nnoremap [d <cmd>PrevDiagnostic<cr>
nnoremap ]d <cmd>NextDiagnostic<cr>
call sign_define("LspDiagnosticsErrorSign", {"text" : "?", "texthl" : "GruvboxRedSign"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "?", "texthl" : "GruvboxOrangeSign"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "?", "texthl" : "GruvboxGreeSign"})
call sign_define("LspDiagnosticsHintSign", {"text" : "?", "texthl" : "GruvboxGreeSign"})

Plug 'nvim-lua/lsp-status.nvim'
" }}}

" vim-airline {{{
Plug 'vim-airline/vim-airline'
let g:airline_extensions = ['tabline', 'quickfix', 'branch']
let g:airline#extensions#tabline#enabled = 1

" show the airline_tab type is tab or buffer (top right)
let g:airline#extensions#tabline#show_tab_type = 1

" close symbol (top right)
let g:airline#extensions#tabline#close_symbol = 'X'

" enable displaying buffers with a single tab
" it mean airline_tab type is buffer
let g:airline#extensions#tabline#show_buffers = 1
" Show the buffer order with a single tab
" convient to use <leader>n to switch buffer
let g:airline#extensions#tabline#buffer_idx_mode = 1

" if airline_tab type is tab
" convient to use <leader>n to switch tap
let g:airline#extensions#tabline#tab_nr_type = 1

" disable show split information on top right
let g:airline#extensions#tabline#show_splits = 0

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
" }}}

" vim-sayonara (sane buffer/window deletion) {{{
Plug 'mhinz/vim-sayonara', {'on': 'Sayonara'}
let g:sayonara_filetypes = {
            \ 'nerdtree': 'NERDTreeClose',
            \ 'tagbar': 'TagbarClose'
            \ }
nnoremap <silent> <leader>c <cmd>Sayonara!<CR>
nnoremap <silent> <leader>q <cmd>Sayonara<CR>
" }}}

" nerdtree {{{
Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle'}
nnoremap <f4> <cmd>NERDTreeToggle<cr>
" }}}

" tagbar {{{
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
let g:tagbar_ctags_bin = system('echo -n "$(which ctags)"')
noremap <F8> <cmd>TagbarToggle<cr>
let g:tagbar_sort = 0
let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }
" }}}

" auto-pairs {{{
Plug 'Raimondi/delimitMate'
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_nesting_quotes = ['"', "'"]
" }}}

" vim-autoformat (code formatter) {{{
Plug 'Chiel92/vim-autoformat', {'on': 'Autoformat'}
noremap <F3> <cmd>Autoformat<cr>
let g:formatters_python = ['autopep8']
let g:formatters_rust = ['rustfmt']
" }}}

" undo tree {{{
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
nnoremap <F6> <cmd>UndotreeToggle<cr>
" }}}

" vim-sinify (show git diff and stages/undoes hunks) {{{
Plug 'mhinz/vim-signify'
exe 'source' $NVIMRC.'/config/signify.vim'
" }}}

" vim-asterisk (star improved) {{{
Plug 'haya14busa/vim-asterisk'

Plug 'haya14busa/is.vim'
let g:asterisk#keeppos = 1
map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)

Plug 'osyo-manga/vim-anzu'
map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)zzzv
map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)zzzv
" nmap n <Plug>(anzu-mode-n)
" nmap N <Plug>(anzu-mode-N)
" }}}

"  vim-better-whitespace {{{
Plug 'ntpeters/vim-better-whitespace', {'on': ['ToggleWhitespace', 'StripWhitespace', 'EnableWhitespace']}
let g:better_whitespace_ctermcolor='3'
let g:better_whitespace_guicolor = '#c8e6c9'
let g:better_whitespace_filetypes_blacklist = ['nerdtree', 'help', 'qf', 'diff']
nnoremap <silent><expr><F5> exists("g:better_whitespace_enabled") ? ':ToggleWhitespace<cr>' : ':EnableWhitespace<cr>'
" <S-F5> for stripping white space
nnoremap <F17> <cmd>StripWhitespace<cr>
" }}}

" cscope in quickfix window {{{
Plug 'ronakg/quickr-cscope.vim'
let g:quickr_cscope_keymaps = 0
nmap <C-s>s <Plug>(quickr_cscope_symbols)
nmap <C-s>g <Plug>(quickr_cscope_global)
nmap <C-s>c <Plug>(quickr_cscope_callers)
nmap <C-s>f <Plug>(quickr_cscope_files)
nmap <C-s>i <Plug>(quickr_cscope_includes)
nmap <C-s>t <Plug>(quickr_cscope_text)
nmap <C-s>e <Plug>(quickr_cscope_egrep)
nmap <C-s>d <Plug>(quickr_cscope_functions)
" }}}

" focus programming {{{
Plug 'junegunn/goyo.vim', {'on':['Goyo', 'Goyo!']}
noremap <silent><expr> <F2> exists('#goyo') ? '<cmd>Goyo!<cr>':'<cmd>Goyo<cr>'

Plug 'junegunn/limelight.vim', {'on':['Limelight', 'Limelight!', '<Plug>(Limelight)']}
" }}}

" qfreplace {{{
Plug 'thinca/vim-qfreplace', {'on': 'Qfreplace'}
" }}}

" vim-easy-align {{{
Plug 'junegunn/vim-easy-align', {'on':['EasyAlign', '<Plug>(EasyAlign)']}
" }}}

" gruvbox {{{
Plug 'morhetz/gruvbox'
let g:gruvbox_termcolors=256
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_vert_split="bg0"
" }}}
call plug#end()

set bg=dark
colorscheme gruvbox


function! s:lsp_setting() abort
lua << EOF
    local lsp_status = require('lsp-status')
    lsp_status.register_progress()

    local nvim_lsp = require'nvim_lsp'
    local on_attach_vim = function(client, bufnr)
        require'completion'.on_attach(client, bufnr)
        require'diagnostic'.on_attach(client, bufnr)
        lsp_status.on_attach(client)
    end
    nvim_lsp.gopls.setup{
        init_options= { usePlaceholders = true },
        on_attach=on_attach_vim
    }
EOF
exe 'source' $NVIMRC.'/config/completion_nvim.vim'
endfunction
call s:lsp_setting()

" vim: set foldmethod=marker tw=80 sw=4 ts=4 sts =4 sta nowrap et :
