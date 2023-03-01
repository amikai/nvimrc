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
                    -- lua
                    null_ls.builtins.formatting.stylua.with({
                        extra_args = {
                            "--indent-type",
                            "Spaces",
                            "--indent-width",
                            "4",
                        },
                    }),
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
