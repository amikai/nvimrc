local M = {}

local g = vim.g
local km = require('my_config.utils').km
local lsp = vim.lsp
local autocmd = require('my_config.utils').autocmd

local diagnostic = function()
    lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
        lsp.diagnostic.on_publish_diagnostics, {
            -- Enable underline, use default values
            underline = true,
            -- Enable virtual text, override spacing to 2
            virtual_text = {
            spacing = 2,
            prefix = '<',
        },
        -- Use a function to dynamically turn signs off
        -- and on, using buffer local variables
        signs = function(bufnr, client_id)
            local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
            -- No buffer local variable set, so just enable by default
            if not ok then
                return true
            end

            return result
        end,
        -- Disable a feature
        update_in_insert = false,
      }
    )
end

function M.basic_setting()
    diagnostic()
    autocmd('MyAutoCmd', [[ CursorHold <buffer> lua vim.lsp.buf.document_highlight() ]], false)
    autocmd('MyAutoCmd', [[ CursorHoldI <buffer> lua vim.lsp.buf.document_highlight() ]], false)
    autocmd('MyAutoCmd', [[ CursorMoved <buffer> lua vim.lsp.buf.clear_references() ]], false)

    km('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {})
    km('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {})
end

return M
