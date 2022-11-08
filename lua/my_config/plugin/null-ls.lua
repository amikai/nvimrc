local M = {}
local utils = require("my_config.utils")

local null_ls = require("null-ls")

function M.config()
    null_ls.setup({
        sources = {
            -- lua
            null_ls.builtins.formatting.stylua.with({
                extra_args = {
                    '--indent-type Spaces',
                    '--indent-width 4',
                }
            }),
            -- buf
            null_ls.builtins.diagnostics.buf,
            null_ls.builtins.formatting.buf,
        },
    })

    vim.keymap.set("n", "<F9>", utils.toggle_diagnostic_window)
    vim.keymap.set("n", "<F3>", vim.lsp.buf.format)
end

return M
