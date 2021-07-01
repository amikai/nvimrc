local M = {}

local g = vim.g
local echo = vim.api.nvim_echo
local km = require('my_config.utils').km

local gopls_on_attach = function()
    require('lspconfig').gopls.setup{
        init_options= { usePlaceholders = true },
    }
end

function M.config()
    gopls_on_attach()
end

return M
