local M = {}

local g = vim.g
local fn = vim.fn
local km = require('my_config.utils').km

function M.config()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = {
            enable = true,
        },
        indent = {
            endble = true
        },
    }
end

return M
