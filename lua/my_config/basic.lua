local cmd = vim.cmd
local fn = vim.fn
local call = vim.call
local err_writeln = vim.api.nvim_err_writeln
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local opt = function(key, val)
    if vim.o[key] == nil then
        err_writeln("option ${key} invalid")
    end
    vim.o[key] = val
end

local w_opt = function(key, val)
    if vim.wo[key] == nil then
        err_writeln("option ${key} invalid")
    end
    vim.wo[key] = val
end

local km = vim.keymap.set

local g_v = function(key, val)
    vim.g[key] = val
end


-- General {{{
g_v('python_host_prog', 'python')
g_v('python3_host_prog', 'python3')

opt('history', 500)

-- Do not atomically add newline at end of file
opt('fixendofline', false)

-- Set to auto read when a file is changed from the outside
opt('autoread', true)

-- Switch buffer without casuing error when file is edited
opt('hidden', true)

opt('report', 0)

km('n', '<F12>', vim.fn['my_config#utils#show_function_key'])

km('i', 'jk', '<esc>')
km('t', '<esc>', '<C-\\><C-n>')

km('', '<Space>', '<nop>')
g_v('mapleader', t '<Space>')

opt('termguicolors', true)

opt('encoding', 'utf-8')

opt('fileformats', 'unix,dos,mac')

-- set path+=**

opt('diffopt', 'filler,vertical,algorithm:patience,context:3,foldcolumn:0')

cmd [[ autocmd BufReadPost * call my_config#utils#go_to_original_pos()]]

-- center buffer around cursor when opening files
cmd [[ autocmd BufRead * normal zz ]]

opt('grepprg', 'grep -inH')

cmd [[ augroup MyAutoCmd
           autocmd!
       augroup END ]]

opt('mouse', '')

km('n', 'j', 'gj')
km('n', 'k', 'gk')

km('n', 'G', 'Gzz')

km('n', 'U', '<cmd>redo<cr>')

opt('updatetime', 500)

-- TODO: clipboard behavior

-- Don't yank to default register when changing something
km('x', 'c', '"xc')
km('n', 'c', '"xc')

-- After block yank and paste, move cursor to the end of operated text and don't override register
km('v', 'y', 'y`]')
km('v', 'p', '"_dP`')
km('n', 'p', 'p`]')

-- Copy paste
opt('clipboard', 'unnamedplus')

-- Move visual block
km('v', 'J', ":m '>+1<cr>gv=gv")
km('v', 'K', ":m '<-2<cr>gv=gv")

-- Visual shifting
km('v', '<', '<gv')
km('v', '>', '>gv')

-- Sign column
opt('signcolumn', "auto:2")


-- }}}

-- Vim user interface {{{
opt('scrolloff', 999)

-- Display candidates by popup menu.
opt('wildmenu', true)
opt('wildmode', 'full')
vim.o.wildoptions = vim.o.wildoptions .. ',pum'



-- line number setting
w_opt('number', true)

-- Not use relative number, if not in the window
cmd [[ augroup MyAutoCmd
           autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
           autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
       augroup END ]]


-- Maximum width of text that is being inserted (TODO)
-- set textwidth=80
-- set breakindent
-- set formatoptions=


-- Height of the command bar
opt('cmdheight', 2)

-- Enables pseudo-transparency for a floating window
w_opt('winblend', 20)
-- Set minimal width for current window.
opt('winwidth', 30)
-- Set minimal height for current window.
-- opt('winheight', 20)
-- Set maximam maximam command line window.
opt('cmdwinheight', 3)
--  No equal window size.
opt('equalalways', false)

-- Adjust window size of preview and help
opt('previewheight', 5)
opt('helpheight', 12)

-- Puts new vsplit windows to the right of the current
opt('splitright', true)
-- Puts new split windows to the bottom of the current
opt('splitbelow', true)

-- show command
opt('showcmd', true)

opt('showmode', true)


-- Always show current position
opt('ruler', true)


-- Ignore case when searching
opt('ignorecase', true)


-- When searching try to be smart about cases
opt('smartcase', true)


-- Configure backspace so it acts as it should act
opt('backspace', 'indent,eol,start')
vim.o.whichwrap = vim.o.whichwrap .. ',<,>,h,l'

w_opt('wrap', false)


-- search
opt('incsearch', true) -- search as characters are entered
opt('hlsearch', true) -- highlight matches
opt('inccommand', 'split')

-- mark before search
km('n', '/', 'ms/', {noremap = true})



-- Show matching brackets when text indicator is over them
opt('showmatch', true)
opt('matchtime', 1)


-- show special character
w_opt('list', true)
opt('listchars', 'eol:¬,tab:▸ ,trail:.')


-- highlight current line
w_opt('cursorline', true)
w_opt('cursorcolumn', true)
w_opt('colorcolumn', '81')

-- Add a bit extra margin to the left
w_opt('foldcolumn', '1')


-- Use a popup menu to show the possible completions
opt('completeopt', 'menuone,noinsert,noselect')

vim.o.shortmess = vim.o.shortmess .. 'cF'

opt('virtualedit', 'block')

-- Use tab to choose condidate in pop up menu
cmd [[ augroup MyAutoCmd
           autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
       augroup END ]]

-- Set popup menu max height.
opt('pumheight', 10)

-- Enables pseudo-transparency for the popup-menu
opt('pumblend', 20)

--- }}}

-- Files, backups and undo file {{{
opt('backup', false)

opt('writebackup', false)

opt('swapfile', false)

opt('undofile', true)
-- }}}

-- Indent and tab {{{
-- indent width
opt('shiftwidth', 4)
-- tab width
opt('tabstop', 4)

opt('softtabstop', 4)

-- space replace tab
opt('expandtab', true)

opt('smarttab', true)

-- set autoindent
-- set smartindent
-- }}}

-- Moving around, tabs, windows and buffers {{{

-- Smart way to move between windows
km('n', '<C-j>', '<C-W>j')
km('n', '<C-k>', '<C-W>k')
km('n', '<C-h>', '<C-W>h')
km('n', '<C-l>', '<C-W>l')

-- Close current tab
km('n', '<leader>qt', '<cmd>tabclose<cr>')

-- Close all the buffers
km('n', '<leader>ba', '<cmd>bufdo bd<cr>')

-- Managing tabs
km('n', '<leader>t', '<cmd>tabnew<cr>')
-- gt => <cmd>tabnext<cr>
-- gT => <cmd>tabprevious<cr>

cmd [[ augroup MyAutoCmd
           autocmd CursorHold *? syntax sync minlines=300
           autocmd FileType qf wincmd J
            autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 500)
       augroup END ]]

-- }}}

-- command line mode {{{
km('c', '<C-a>', '<Home>')
km('c', '<C-e>', '<End>')
km('c', '<C-p>', '<Up>')
km('c', '<C-n>', '<Down>')
km('c', '<C-b>', '<Left>')
km('c', '<C-f>', '<Right>')
km('c', '<M-b>', '<S-Left>')
km('c', '<M-f>', '<S-Right>')

-- }}}

-- vim: set foldmethod=marker tw=80 sw=4 ts=4 sts =4 sta nowrap et :
