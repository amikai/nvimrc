local M = {}

local g = vim.g
local km = require('my_config.utils').km
local lsp = vim.lsp
local autocmd = require('my_config.utils').autocmd
local fn = vim.fn
local cmd = vim.cmd

M.diagnostic_setting = function()
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

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, config)
end

M.open_diagnostic_window = function()
    local diagnostics = vim.lsp.diagnostic.get_all()
    local loclist = {}
    for bufnr, diagnostic in pairs(diagnostics) do
        for _, d in ipairs(diagnostic) do
            d.bufnr = bufnr
            d.lnum = d.range.start.line + 1
            d.col = d.range.start.character + 1
            d.text = d.message
            table.insert(loclist, d)
        end
    end
    vim.lsp.util.set_loclist(loclist)
    cmd [[lopen]]
    cmd [[wincmd J]]
    cmd [[5wincmd _]]
    cmd [[wincmd p]]
end

return M
