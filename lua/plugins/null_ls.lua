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
        "nvimtools/none-ls.nvim",
        name = "null-ls",
        config = function()
            local null_ls = require("null-ls")
            local helpers = require("null-ls.helpers")
            null_ls.setup({
                sources = {
                    -- trailing whitespace
                    null_ls.builtins.diagnostics.trail_space,
                    -- github action
                    null_ls.builtins.diagnostics.actionlint,
                },
            })
        end,
    },
}
