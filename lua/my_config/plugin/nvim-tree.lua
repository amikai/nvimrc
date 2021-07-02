local M = {}

local g = vim.g
local autocmd = require('my_config.utils').autocmd
local km = require('my_config.utils').km

function M.setup()
    km('n', '<F4>', '<cmd>NvimTreeToggle<cr>', {noremap = true})
    g.nvim_tree_indent_markers = 1
    g.nvim_tree_add_trailing = 1
    g.nvim_tree_show_icons = {
        git = 0,
        folders = 1,
        files = 0,
        folder_arrows = 0,
    }
    g.nvim_tree_icons = {
        folder = {
            arrow_open = "▾",
            arrow_closed = "▸",
            default = "▸",
            open = "▾",
            empty = "▸",
            empty_open = "▾",
            symlink = "▸",
            symlink_open = "▾",
        }
    }

end


return M
