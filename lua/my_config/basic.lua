local cmd = vim.cmd
local fn = vim.fn

local km = require("my_config.utils").km_factory({ silent = true })

local g = vim.g
local o = vim.opt
local go = vim.go

local autocmd = vim.api.nvim_create_autocmd

-- General {{{
-- -- Do not atomically add newline at end of file
o.fixendofline = false

o.report = 0

km("n", "<F12>", require("my_config.utils").show_function_keymapping)
km("n", "<F60>", require("my_config.utils").show_alt_function_keymapping)

km("i", "jk", "<esc>")
km("t", "<esc>", "<C-\\><C-n>")

km("", "<Space>", "<nop>")

g.mapleader = " "

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

-- After block yank, move cursor to the end of yanked text
km("v", "y", "y`]")

-- -- Copy paste
o.clipboard = { "unnamedplus" }

-- Move visual block
km("v", "J", ":m '>+1<cr>gv=gv")
km("v", "K", ":m '<-2<cr>gv=gv")

-- Visual shifting
km("v", "<", "<gv")
km("v", ">", ">gv")

-- Set the status line to global
go.laststatus = 3

-- Add angle brackets to match pair
o.matchpairs:prepend { "<:>" }
-- -- }}}

-- -- Vim user interface {{{
o.scrolloff = 3

-- line number setting
o.number = true

-- Maximum width of text that is being inserted (TODO)
o.textwidth = 80
-- set breakindent
-- set formatoptions=

-- Height of the command bar
o.cmdheight = 2

-- Enables pseudo-transparency for a floating window
o.winblend = 20
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

-- Ignore case when searching
o.ignorecase = true

-- When searching try to be smart about cases
o.smartcase = true

o.whichwrap:append({ ["<"] = true, [">"] = true, h = true, l = true })

o.wrap = false

-- Show the effects of a command incrementally in a preview split
o.inccommand = "split"

-- Show matching brackets when text indicator is over them
o.showmatch = true
o.matchtime = 1

-- -- show special character
o.list = true
o.listchars = { eol = "¬", tab = "▸ ", trail = "." }

-- highlight current line
o.cursorline = true
o.cursorcolumn = true
o.colorcolumn = "81"

-- -- Add a bit extra margin to the left
o.foldcolumn = "1"

-- -- Use a popup menu to show the possible completions
o.completeopt = { "menuone", "noinsert", "noselect" }


o.shortmess:append({ c = true, F = true })

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
        vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
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
    signs = true,
    float = {
        format = function(diagnostic)
            return diagnostic.message
        end,
        suffix = function(diagnostic)
            return string.format(" [%s]", diagnostic.source), ""
        end,
    },
    -- Show the float after jumping with the default ]d/[d mappings.
    -- "float" in vim.diagnostic.JumpOpts is deprecated since 0.12.
    jump = {
        on_jump = function(diagnostic, bufnr)
            if not diagnostic then
                return
            end
            vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
        end,
    },
})

km('n', '=q', function()
    vim.diagnostic.setqflist({ open = false })

    -- if qf window is not present, return winid is zero
    local qf_winid = fn.getqflist({ winid = 0 }).winid
    local action = qf_winid > 0 and 'cclose' or 'copen'
    cmd('botright ' .. action)
end)

km('n', '=l', function()
    vim.diagnostic.setloclist({ open = false })
    local win = vim.api.nvim_get_current_win()
    local qf_winid = fn.getloclist(win, { winid = 0 }).winid
    local action = qf_winid > 0 and 'lclose' or 'lopen'
    cmd(action)
end)
--- }}}

-- detect hurl file
vim.filetype.add({
    extension = {
        hurl = 'hurl',
    }
})

-- vim: set foldmethod=marker tw=80 sw=4 ts=4 sts =4 sta nowrap et :
