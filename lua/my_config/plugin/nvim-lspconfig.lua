local M = {}

local g = vim.g
local echo = vim.api.nvim_echo
local km = require('my_config.utils').km

local lsp_basic_setting = require('my_config.lsp').basic_setting

local gopls_on_attach = function()
    lsp_basic_setting()
end

function M.config()
    require('lspconfig').gopls.setup{
        init_options= { usePlaceholders = true },
        on_attach = gopls_on_attach,
    }
end

return M
