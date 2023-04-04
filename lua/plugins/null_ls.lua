return {
    {
        "jayp0521/mason-null-ls.nvim",
        dependencies = "williamboman/mason.nvim",
        opts = {
            ensure_installed = nil,
            automatic_installation = true,
            automatic_setup = false,
        },
        config = function(_, opts)
            require("mason-null-ls").setup(opts)
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    -- trailing whitespace
                    null_ls.builtins.diagnostics.trail_space,
                    null_ls.builtins.formatting.trim_whitespace,
                    -- buf
                    null_ls.builtins.diagnostics.buf,
                    null_ls.builtins.formatting.buf,
                    -- python
                    null_ls.builtins.formatting.black,
                    -- bash
                    null_ls.builtins.diagnostics.shellcheck,
                },
            })
        end,
    },
}
