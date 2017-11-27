""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

set history=500

" Set to auto read when a file is changed from the outside
set autoread

" Enable filetype plugins
filetype indent on
filetype plugin on
inoremap jk <esc>

let mapleader=","
let g:mapleader=","
let maplocalleader=";"

command W w !sudo tee % > /dev/null

set path+=**

" Remember cursor position between vim sessions
autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
    " center buffer around cursor when opening files
autocmd BufRead * normal zz

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Basic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap j gj
nnoremap k gk

nnoremap J 5j
nnoremap K 5k

nnoremap H ^
nnoremap L $

" set esc to noh highlight
nnorema <esc> <esc>:noh<return><esc>
inoremap <esc> <esc>:noh<return><esc>

" copy paste
set clipboard+=unnamedplus


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Maximum width of text that is being inserted (TODO)
" set textwidth=80
" set breakindent
" set formatoptions=


" visual autocomplete for command menu
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.pyc,*~


" line number setting
set number
set relativenumber


" Height of the command bar
set cmdheight=2


" show command
set showcmd
set showmode


"Always show current position
" set ruler


" Ignore case when searching
set ignorecase


" When searching try to be smart about cases
set smartcase


" Configure backspace so it acts as it should act
set backspace=indent,eol,start
set whichwrap+=<,>,h,l


" search
set incsearch           " search as characters are entered
set hlsearch            " highlight matches


" Don't redraw while executing macros (good performance config)
set lazyredraw


" Show matching brackets when text indicator is over them
set showmatch
set matchtime=1


" show special character
set listchars=eol:¬,tab:▸\ ,trail:.,


"highlight current line
set cursorline
set cursorcolumn
set colorcolumn=81

" Add a bit extra margin to the left
set foldcolumn=1


" Use a popup menu to show the possible completions
set completeopt-=preview



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
" syntax enable
syntax on

set t_Co=256

" Set utf8 as standard enconding
set encoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Confiugre white space
set shiftwidth=4 "indent width
set tabstop=4    "tab width
set softtabstop=4
set expandtab   "space replace tab
set smarttab "Be smart when using tab

" for makefile
autocmd FileType make setlocal noexpandtab


set autoindent
set smartindent


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode relate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv


" Visual mode pressing * or # searches for the current selection
vnoremap <slient> * :<C-u>call VisualSelection('','')<CR>/<C-R>=@/<CR><CR>
vnoremap <slient> # :<C-u>call VisualSelection('','')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Puts new vsplit windows to the right of the current
set splitright
" Puts new split windows to the bottom of the current
set splitbelow


" Smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Close current buffer
nnoremap <silent> <leader>q :lclose<bar>b#<bar>bd #<CR>
nnoremap <silent> <leader>qt :tabclose<cr>
" Close all the buffers
noremap <leader>ba :bufdo bd<cr>

" Move between buffer
" noremap <leader>l :bnext<cr>
" noremap <leader>h :bprevious<cr>
noremap ]b :bnext<cr>
noremap [b :bprevious<cr>

" Managing tabs
" noremap <leader>nt :tabnew<cr>
" noremap <leader>to :tabonly<cr>
" noremap <leader>tc :tabclose<cr>
" noremap <leader>tm :tabmove
" noremap <leader>tn :tabnext
" noremap <leader>th :tabprev<cr>
" noremap <leader>tl :tabnext<cr>
noremap <leader>t :tabnew<cr>
noremap ]t :tabnext<cr>
noremap [t :tabprev<cr>

" Opens a new tab with the current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => command line mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" command line mode work like shell
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

