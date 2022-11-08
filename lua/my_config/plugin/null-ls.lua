local M = {}

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
end

return M
