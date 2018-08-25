""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Enviroment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists("g:python_host_prog")
    " echo -n for trimming newline
    let g:python_host_prog = system('echo -n "$(which python)"')
endif

if !exists("g:python3_host_prog")
    " echo -n for trimming newline
    let g:python3_host_prog = system('echo -n "$(which python3)"')
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=500

" Set to auto read when a file is changed from the outside
set autoread

" Enable filetype plugins
filetype indent plugin on
inoremap jk <esc>
tnoremap <esc> <C-\><C-n>

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
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>

nnoremap j gj
nnoremap k gk

nnoremap H ^
nnoremap L $

" set esc to noh highlight
nnoremap <esc> <esc>:noh<return><esc>
inoremap <esc> <esc>:noh<return><esc>

" map U to redo
noremap U :redo<cr>

" copy paste
set clipboard+=unnamedplus


" Don't yank to default register when changing something
xnoremap c "xc
nnoremap c "xc

" After block yank and paste, move cursor to the end of operated text and don't override register
vnoremap y y`]
vnoremap p "_dP`]
nnoremap p p`]

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
set inccommand=split    " show the effect of :s, :sm, and :sno command


" Don't redraw while executing macros (good performance config)
set lazyredraw


" Show matching brackets when text indicator is over them
set showmatch
set matchtime=1


" show special character
set list listchars=eol:¬,tab:▸\ ,trail:.


"highlight current line
set cursorline
set cursorcolumn
set colorcolumn=81

" Add a bit extra margin to the left
set foldcolumn=1


" Use a popup menu to show the possible completions
set completeopt-=preview

" Use tab to choose condidate in pop up menu
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
" syntax enable
syntax on

set t_Co=256
set termguicolors

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

set undofile
set undodir=$HOME/.config/nvim/undo

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

" for nasm
au BufRead,BufNewFile *.asm set filetype=nasm

set autoindent
set smartindent


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode relate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

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

" Close current tab
nnoremap <silent> <leader>qt :tabclose<cr>

" Use vim-sayonara plugin
" <leader>q => Close current buffer and window
" <leader>c => Close current buffer


" Close all the buffers
noremap <leader>ba :bufdo bd<cr>


" Move between buffer
" Use tpope/vim-unimpaired replace below
" noremap ]b :bnext<cr>
" noremap [b :bprevious<cr>

" Managing tabs
noremap <leader>t :tabnew<cr>
" gt => :tabnext
" gT => :tabprevious

" Opens a new tab with the current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" When jump to next match also center screen
" Note: Use :norm! to make it count as one command. (i.e. for i_CTRL-o)
nnoremap <silent> n :norm! nzz<CR>
nnoremap <silent> N :norm! Nzz<CR>
vnoremap <silent> n :norm! nzz<CR>
vnoremap <silent> N :norm! Nzz<CR>
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

augroup MyAutoCmd
    autocmd!
    autocmd CursorHold *? syntax sync minlines=300
    autocmd VimEnter * call vimrc#colors_random()

    " Not use relative number, if not in the window
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END
nnoremap <silent><F7> :call vimrc#colors_random()<cr><cr>
nnoremap <silent><F12> :call vimrc#show_function_key()<cr>

let g:colorscheme_bg_list = {}
