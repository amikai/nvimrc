""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Enviroment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('g:python_host_prog')
    " echo -n for trimming newline
    let g:python_host_prog = system('echo -n "$(which python)"')
endif

if !exists('g:python3_host_prog')
    " echo -n for trimming newline
    let g:python3_host_prog = system('echo -n "$(which python3)"')
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=500

" Set to auto read when a file is changed from the outside
set autoread

" Switch buffer without casuing error when file is edited
set hidden

set report=0

inoremap jk <esc>
tnoremap <esc> <C-\><C-n>

nnoremap <SPACE> <Nop>
let mapleader="\<Space>"
let g:mapleader="\<Space>"
let maplocalleader="\<Space>"

command! W w !sudo tee % > /dev/null

set path+=**

set diffopt=filler,vertical,algorithm:patience,context:3,foldcolumn:0

noremap <silent><F1> <cmd>call vimrc#load_session()<cr>

" Remember cursor position between vim sessions
autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \   exe "normal! g'\"" |
            \ endif
" center buffer around cursor when opening files
autocmd BufRead * normal zz

set grepprg=grep\ -inH


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

nnoremap G Gzz

" set esc to noh highlight
function s:esc_mapping()
    let s:cmds = [
                \ 'set nopaste',
                \ 'call vimrc#close_floating_window()',
                \]

    let s:all_cmds = ""
    for cmd in s:cmds
        let s:all_cmds = s:all_cmds . "\<cmd>" . cmd . "\<cr>"
    endfor
    return printf(s:all_cmds . "\<esc>")
endfunction
noremap <expr><esc> <SID>esc_mapping()



" map U to redo
noremap U <cmd>redo<cr>

" copy paste
set clipboard+=unnamedplus

set updatetime=500

" Don't yank to default register when changing something
xnoremap c "xc
nnoremap c "xc

" After block yank and paste, move cursor to the end of operated text and don't override register
vnoremap y y`]
vnoremap p "_dP`]
nnoremap p p`]

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Cursor always in vertical center on the screen
set scrolloff=999

" Maximum width of text that is being inserted (TODO)
" set textwidth=80
" set breakindent
" set formatoptions=

" Display candidates by popup menu.
set wildmenu
set wildmode=full
set wildoptions+=pum

" line number setting
set number
set relativenumber


" Height of the command bar
set cmdheight=2

" Enables pseudo-transparency for a floating window
set winblend=20
" Set minimal width for current window.
set winwidth=30
" Set minimal height for current window.
set winheight=20
" Set maximam maximam command line window.
set cmdwinheight=5
" No equal window size.
set noequalalways

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

set nowrap


" search
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
if exists('+inccommand')
    set inccommand=split    " show the effect of :s, :sm, and :sno command
endif

" mark before search
nnoremap / ms/


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
set completeopt=menuone,noinsert,noselect

set shortmess+=c

set virtualedit=block

" Use tab to choose condidate in pop up menu
augroup MyAutoCmd
    autocmd!
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

" Set popup menu max height.
set pumheight=10

" Enables pseudo-transparency for the popup-menu
set pumblend=20



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
set fileformats=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup
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

" for nasm
augroup MyAutoCmd
    autocmd BufRead,BufNewFile *.asm set filetype=nasm
augroup END

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

" Adjust window size of preview and help.
set previewheight=5
set helpheight=12

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
nnoremap <silent> <leader>qt <cmd>tabclose<cr>

" Use vim-sayonara plugin
" <leader>q => Close current buffer and window
" <leader>c => Close current buffer


" Close all the buffers
noremap <leader>ba <cmd>bufdo bd<cr>


" Move between buffer
" Use tpope/vim-unimpaired replace below
" noremap ]b <cmd>bnext<cr>
" noremap [b <cmd>bprevious<cr>

" Managing tabs
noremap <leader>t <cmd>tabnew<cr>
" gt => <cmd>tabnext<cr>
" gT => <cmd>tabprevious<cr>

" Opens a new tab with the current buffer's path
map <leader>te <cmd>Texplore<cr>

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
    autocmd CursorHold *? syntax sync minlines=300

    " Not use relative number, if not in the window
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif

    autocmd FileType,Syntax,BufNewFile,BufNew,BufRead call vimrc#on_filetype()
    autocmd FileType qf wincmd J
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 500)
augroup END
nnoremap <silent><F12> <cmd>call vimrc#show_function_key()<cr>
nnoremap <silent><expr> q winnr('$') != 1 ? ':<C-u>close<CR>' : ""

