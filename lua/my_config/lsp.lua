local M = {}

local g = vim.g
local km = require('my_config.utils').km
local lsp = vim.lsp
local autocmd = require('my_config.utils').autocmd
local fn = vim.fn

local diagnostic = function()
        config = {
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

        local method = "textDocument/publishDiagnostics"
        local default_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = function(err, method, result, client_id, bufnr, config)
            default_handler(err, method, result, client_id, bufnr, config)
            -- put disgnostics to msg
            local diagnostics = vim.lsp.diagnostic.get_all()
            local qflist = {}
            for bufnr, diagnostic in pairs(diagnostics) do
                for _, d in ipairs(diagnostic) do
                    d.bufnr = bufnr
                    d.lnum = d.range.start.line + 1
                    d.col = d.range.start.character + 1
                    d.text = d.message
                    table.insert(qflist, d)
                end
            end
            vim.lsp.util.set_qflist(qflist)
        end
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
