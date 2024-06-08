local cmd = vim.cmd
local fn = vim.fn
local call = vim.call

local km = require("my_config.utils").km_factory({ silent = true })

local g = vim.g
local o = vim.opt
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
km("n", "<F60>", require("my_config.utils").show_alt_function_keymapping)

km("i", "jk", "<esc>")
km("t", "<esc>", "<C-\\><C-n>")

km("", "<Space>", "<nop>")

g.mapleader = term("<Space>")

o.termguicolors = true

o.encoding = "utf-8"

o.fileformats = { "unix", "dos", "mac" }

o.path:append("**")

o.diffopt = { "filler", "vertical", "algorithm:patience", "context:3", "foldcolumn:0", "linematch:256" }

-- -- center buffer around cursor when opening files
autocmd("BufRead", { pattern = "*", command = "normal zz" })

if vim.fn.executable('rg') == 1 then
    o.grepprg = "rg --vimgrep --no-heading --smart-case"
else
    o.grepprg = "grep -inH"
end

o.mouse = {}

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
o.clipboard = { "unnamedplus" }

-- Move visual block
km("v", "J", ":m '>+1<cr>gv=gv")
km("v", "K", ":m '<-2<cr>gv=gv")

-- Visual shifting
km("v", "<", "<gv")
km("v", ">", ">gv")

-- Set the status lien to global
go.laststatus = 3

-- -- }}}

-- -- Vim user interface {{{
o.scrolloff = 3

-- -- Display candidates by popup menu.
o.wildmenu = true
o.wildmode = { "full" }
o.wildoptions:append("pum")

-- line number setting
o.number = true

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
o.backspace = { "indent", "eol", "start" }
o.whichwrap:append({ ["<"] = true, [">"] = true, h = true, l = true })

o.wrap = false

-- search
o.incsearch = true -- search as characters are entered
o.hlsearch = true  -- highlight matches
o.inccommand = "split"

-- Show matching brackets when text indicator is over them
o.showmatch = true
o.matchtime = 1

-- -- show special character
wo.list = true
o.listchars = { eol = "¬", tab = "▸ ", trail = "." }

-- highlight current line
wo.cursorline = true
wo.cursorcolumn = true
wo.colorcolumn = "81"

-- -- Add a bit extra margin to the left
o.foldcolumn = "1"

-- -- Use a popup menu to show the possible completions
o.completeopt = { "menuone", "noinsert", "noselect" }


o.shortmess:append({c = true, F = true})

o.virtualedit = "block"

autocmd({ "InsertLeave", "CompleteDone" }, {
    pattern = "*",
    callback = function()
        if fn.pumvisible() == 0 then
            cmd("pclose")
        end
    end,
})

o.pumheight = 10

-- Enables pseudo-transparency for the popup-menu
o.pumblend = 20

-- In Neovim 0.10, hl-WinSeparator is linked to hl-Normal instead of hl-VertSplit.
-- This alteration affects my UI experience, so I'm reverting it to the original setting.
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
        vim.api.nvim_set_hl(0, 'WinSeparator', { link = 'VertSplit', force = true })
    end,
})

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
autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})

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

--- diagnstic setting {{{
vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    sign = true,
    float = {
        format = function(diagnostic)
            return diagnostic.message
        end,
        suffix = function(diagnostic)
            return string.format(" [%s]", diagnostic.source), ""
        end,
    },
})

km("n", "]d", function()
    vim.diagnostic.goto_next({ float = true })
end)

km("n", "]d", function()
    vim.diagnostic.goto_prev({ float = true })
end)

vim.keymap.set('n', '=q', function()
    vim.diagnostic.setqflist({ open = false })

    -- if qf window is not present, return winid is zero
    local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
    local action = qf_winid > 0 and 'cclose' or 'copen'
    vim.cmd('botright ' .. action)
end, { noremap = true })

vim.keymap.set('n', '=l', function()
    vim.diagnostic.setloclist({ open = false })
    local win = vim.api.nvim_get_current_win()
    local qf_winid = vim.fn.getloclist(win, { winid = 0 }).winid
    local action = qf_winid > 0 and 'lclose' or 'lopen'
    vim.cmd(action)
end, { noremap = true })
--- }}}

-- detect hurl file
vim.filetype.add({
    extension = {
        hurl = 'hurl',
    }
})

-- vim: set foldmethod=marker tw=80 sw=4 ts=4 sts =4 sta nowrap et :
