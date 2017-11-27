
call plug#begin('~/.config/nvim/plugged')

" color scheme
Plug 'morhetz/gruvbox'  
Plug 'cocopon/iceberg.vim'

" indent line
Plug 'Yggdroot/indentLine'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" easymotion
Plug 'easymotion/vim-easymotion'

" tagbar 
" use universal-ctag is better
Plug 'majutsushi/tagbar'
" automatically update tags files
" This will only work on projects that after ctags -R
" (TODO: to be set)
Plug 'craigemery/vim-autotag'
" Plug 'jsfaint/gen_tags.vim'

" file navigator
Plug 'scrooloose/nerdtree'
" nerdtree-git-plugin
Plug 'Xuyuanp/nerdtree-git-plugin'

" auto-pair
Plug 'jiangmiao/auto-pairs'

" rainbow parentheses
Plug 'luochen1990/rainbow'

" show git diff (TODO: To be set)
Plug 'airblade/vim-gitgutter'

" for clang format and pep8 (TODO: To be set)
Plug 'Chiel92/vim-autoformat'

" undo tree (TODO: To be set)
Plug 'simnalamburt/vim-mundo'

"  fugitive (TODO: to be set)
Plug 'tpope/vim-fugitive'

" denite (TODO: to be set)
Plug 'Shougo/denite.nvim'

call plug#end()

" color scheme {{{
set bg=dark
" set termguicolors
"let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox
"colorscheme iceberg

" }}}

" airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:neosolarized_contrast = "high"
" }}}

" NERDTree {{{

" Press F5 open file navigator
nnoremap <F5> :NERDTreeToggle<cr>

" Open file navigator by default
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" }}}

" Rainbow Parentheses Improved {{{
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
" }}}

" Tagbar {{{
noremap <F8> :TagbarToggle<cr>
noremap <leader>tj :TagbarOpen j<cr>

" }}}

" mundo {{{
set undofile
set undodir=$HOME/.config/nvim/undo
" }}}

" denite {{{
noremap [denite-leader] <Nop>
nmap ; [denite-leader]


call denite#custom#option('_', {
    \ 'prompt': 'λ:',
    \ 'winheight': 10,
    \ 'updatetime': 1,
    \ 'auto_resize': 1,
    \ 'source_names': 'short',
    \ 'empty': 0,
    \ 'auto-resume': 1,
    \ 'auto-accel': 1,
    \})
"   'vertical_preview': 1, " use it when needed



" TODO: Denite outline and ctags setting
"
" ctrlp
nnoremap <silent> <C-p> :<C-u>Denite -mode=normal file_rec<CR>

" search in this file (create buffer name called search)
nnoremap <silent> [denite-leader]/ :<C-u>Denite -buffer-name=search -auto-resize line<CR>
" search globally - search recursively from project root (auto-preview is slowly)
nnoremap <silent> [denite-leader]g/ :<C-u>Denite -buffer-name=search -mode=normal grep<CR>
" search current word
nnoremap <silent> [denite-leader]* :<C-u>DeniteCursorWord grep -mode=normal -buffer-name=search line<CR><C-R><C-W><CR>

" denite-key mapping
call denite#custom#map('insert', 'jk', '<denite:enter_mode:normal>')
call denite#custom#map('insert', "<C-j>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-k>", '<denite:move_to_previous_line>')

call denite#custom#map('insert', "<C-t>", '<denite:do_action:tabopen>')
call denite#custom#map('insert', "<C-v>", '<denite:do_action:vsplit>')
call denite#custom#map('normal', "vs", '<denite:do_action:vsplit>')
call denite#custom#map('normal', "sp", '<denite:do_action:split>')

" customize ignore globs
call denite#custom#source('grep', 'matchers', ['matcher_ignore_globs'])
call denite#custom#source('line', 'matchers', ['matcher_ignore_globs'])
call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy','matcher_ignore_globs'])

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [
      \ '.git/', 'build/', '__pycache__/',
      \ 'images/', '*.o', '*.make',
      \ '*.min.*',
      \ 'img/', 'fonts/',
      \ 'tags', 'cscope*'])

" }}}
