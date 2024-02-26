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
            local hurlfmt = helpers.make_builtin({
                name = "hurlfmt",
                method = null_ls.methods.FORMATTING,
                filetypes = { "hurl" },
                -- null_ls.generator creates an async source
                -- that spawns the command with the given arguments and options
                generator_opts = {
                    command = "hurlfmt",
                    to_stdin = true,
                },
                factory = helpers.formatter_factory,
            })
            local trim_whitespace = helpers.make_builtin({
                name = "trim_whitespace",
                meta = {
                    description = "A simple wrapper around `awk` to remove trailing whitespace.",
                },
                method = null_ls.methods.FORMATTING,
                filetypes = {},
                generator_opts = {
                    command = "awk",
                    args = { '{ sub(/[ \t]+$/, ""); print }' },
                    to_stdin = true,
                },
                factory = helpers.formatter_factory,
            })
            null_ls.setup({
                sources = {
                    -- trailing whitespace
                    null_ls.builtins.diagnostics.trail_space,
                    trim_whitespace,
                    -- github action
                    null_ls.builtins.diagnostics.actionlint,
                    -- buf
                    null_ls.builtins.diagnostics.buf,
                    null_ls.builtins.formatting.buf,
                    -- bash
                    null_ls.builtins.formatting.shfmt,
                    hurlfmt,
                },
            })
        end,
    },
}
