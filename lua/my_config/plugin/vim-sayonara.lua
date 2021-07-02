
local M = {}

local g = vim.g
local km = require('my_config.utils').km

function M.setup()
    g.sayonara_filetypes = {
        tagbar = 'TagbarClose',
        NvimTree = 'call defx#call_action("quit")',
    }

    km('n', '<leader>c', '<cmd>Sayonara!<cr>', {silent = true})
    km('n', '<leader>q', '<cmd>Sayonara<cr>', {silent = true})
end

return M
