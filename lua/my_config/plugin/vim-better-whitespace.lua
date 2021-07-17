local M = {}

local g = vim.g
local km = require('my_config.utils').km

function M.setup()
    g.better_whitespace_enabled = 1
    g.better_whitespace_ctermcolor ='3'
    g.better_whitespace_guicolor = '#c8e6c9'
    g.better_whitespace_filetypes_blacklist = {'nerdtree', 'help', 'qf', 'diff'}

    km('n', '<F5>', '<cmd>ToggleWhitespace<cr>', {noremap = true})
end

return M
