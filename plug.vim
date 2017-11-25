
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

"  ack (TODO: to be set)
Plug 'mileszs/ack.vim'

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
