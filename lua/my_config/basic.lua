local cmd = vim.cmd
local fn = vim.fn
local call = vim.call

local km = require("my_config.utils").km
local g = vim.g
local o = vim.o
local go = vim.go
local bo = vim.bo
local wo = vim.wo

local autocmd = vim.api.nvim_create_autocmd

local term = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- General {{{
g.python_host_prog = "python"
g.python3_host_prog = "python3"

o.history = 500

-- -- Do not atomically add newline at end of file
o.fixendofline = false

-- -- Set to auto read when a file is changed from the outside
o.autoread = true

-- -- Switch buffer without casuing error when file is edited
o.hidden = true

o.report = 0

km("n", "<F12>", require("my_config.utils").show_function_keymapping)

km("i", "jk", "<esc>")
km("t", "<esc>", "<C-\\><C-n>")

km("", "<Space>", "<nop>")

g.mapleader = term("<Space>")

o.termguicolors = true

o.encoding = "utf-8"

o.fileformats = "unix,dos,mac"

o.path = o.path .. ",**"

o.diffopt = "filler,vertical,algorithm:patience,context:3,foldcolumn:0"

-- go to original position
autocmd("BufReadPost", { pattern = "*", callback = function()
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, "\""))
    if { row, col } ~= { 0, 0 } then
        vim.api.nvim_win_set_cursor(0, { row, 0 })
    end
end })

-- -- center buffer around cursor when opening files
autocmd("BufRead", { pattern = "*", command = "normal zz" })

o.grepprg = "grep -inH"

o.mouse = ""

km("n", "j", "gj")
km("n", "k", "gk")

km("n", "G", "Gzz")

km("n", "U", "<cmd>redo<cr>")

o.updatetime = 500


-- Don't yank to default register when changing something
km("x", "c", '"xc')
km("n", "c", '"xc')

-- After block yank and paste, move cursor to the end of operated text and don't override register
km("v", "y", "y`]")
km("v", "p", '"_dP`')
km("n", "p", "p`]")

-- -- Copy paste
o.clipboard = "unnamedplus"

-- Move visual block
km("v", "J", ":m '>+1<cr>gv=gv")
km("v", "K", ":m '<-2<cr>gv=gv")

-- Visual shifting
km("v", "<", "<gv")
km("v", ">", ">gv")

-- Sign column
o.signcolumn = "auto:2"

-- -- }}}

-- -- Vim user interface {{{
o.scrolloff = 999

-- -- Display candidates by popup menu.
o.wildmenu = true
o.wildmode = "full"
o.wildoptions = o.wildoptions .. ",pum"

-- line number setting
o.number = true

-- Not use relative number, if not in the window
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
    { pattern = "*", callback = function()
        if o.number then
            vim.o.relativenumber = true
        end
    end })

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
    { pattern = "*", callback = function()
        if o.number then
            vim.o.relativenumber = false
        end
    end })

-- Maximum width of text that is being inserted (TODO)
-- set textwidth=80
-- set breakindent
-- set formatoptions=

-- Height of the command bar
o.cmdheight = 2

-- Enables pseudo-transparency for a floating window
wo.winblend = 20
-- Set minimal width for current window.
o.winwidth = 30
-- Set minimal height for current window.
-- o.winheight = 20
-- Set maximam maximam command line window.
o.cmdwinheight = 3

-- -- Adjust window size of preview and help
o.previewheight = 5
go.helpheight = 10

-- Puts new vsplit windows to the right of the current
o.splitright = true
-- Puts new split windows to the bottom of the current
o.splitbelow = true

-- show command
o.showcmd = true

o.showmode = true

-- Always show current position
o.ruler = true

-- Ignore case when searching
o.ignorecase = true

-- When searching try to be smart about cases
o.smartcase = true

-- -- Configure backspace so it acts as it should act
o.backspace = "indent,eol,start"
o.whichwrap = o.whichwrap .. ",<,>,h,l"

o.wrap = false

-- search
o.incsearch = true -- search as characters are entered
o.hlsearch = true -- highlight matches
o.inccommand = "split"

-- Show matching brackets when text indicator is over them
o.showmatch = true
o.matchtime = 1

-- -- show special character
wo.list = true
o.listchars = "eol:¬,tab:▸ ,trail:."

-- highlight current line
wo.cursorline = true
wo.cursorcolumn = true
wo.colorcolumn = "81"

-- -- Add a bit extra margin to the left
o.foldcolumn = "1"

-- -- Use a popup menu to show the possible completions
o.completeopt = "menuone,noinsert,noselect"

o.shortmess = o.shortmess .. "cF"

o.virtualedit = "block"

autocmd({ "InsertLeave", "CompleteDone" },
    { pattern = "*", callback = function()
        if fn.pumvisible() == 0 then
            cmd("pclose")
        end
    end })

o.pumheight = 10

-- Enables pseudo-transparency for the popup-menu
o.pumblend = 20

-- }}}

-- Files, backups and undo file {{{
o.backup = false

o.writebackup = false

o.swapfile = false

o.undofile = true
-- }}}

-- Indent and tab {{{
-- indent width
o.shiftwidth = 4
-- tab width
o.tabstop = 4

o.softtabstop = 4

-- space replace tab
o.expandtab = true

o.smarttab = true

-- set autoindent
-- set smartindent
-- }}}

-- Moving around, tabs, windows and buffers {{{

-- Smart way to move between windows
km("n", "<C-j>", "<C-W>j")
km("n", "<C-k>", "<C-W>k")
km("n", "<C-h>", "<C-W>h")
km("n", "<C-l>", "<C-W>l")

-- Close current tab
km("n", "<leader>qt", "<cmd>tabclose<cr>")

-- Close all the buffers
km("n", "<leader>ba", "<cmd>bufdo bd<cr>")

-- Managing tabs
km("n", "<leader>t", "<cmd>tabnew<cr>")
-- gt => <cmd>tabnext<cr>
-- gT => <cmd>tabprevious<cr>

autocmd({ "CursorHold" }, { pattern = "*?", command = "syntax sync minlines=300" })
autocmd({ "FileType" }, { pattern = "qf", command = "wincmd J" })
autocmd({ "TextYankPost" }, { pattern = "*", callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
end })

-- }}}

-- command line mode {{{
km("c", "<C-a>", "<Home>")
km("c", "<C-e>", "<End>")
km("c", "<C-p>", "<Up>")
km("c", "<C-n>", "<Down>")
km("c", "<C-b>", "<Left>")
km("c", "<C-f>", "<Right>")
km("c", "<M-b>", "<S-Left>")
km("c", "<M-f>", "<S-Right>")

-- }}}

-- vim: set foldmethod=marker tw=80 sw=4 ts=4 sts =4 sta nowrap et :
