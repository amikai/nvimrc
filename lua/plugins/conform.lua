return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<F3>",
            function()
                require("conform").format({ async = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    -- Everything in opts will be passed to setup()
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            -- See the detail config of golangci-lint in $HOME/.golangci.yaml
            go = { "golangci-lint" },
            -- if shfmt not set here, will fallback to lsp. bashls use shfmt as default formatter,
            -- See the detail: here https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file#dependencies
            -- bash = { "shfmt" },
            graphql = { "prettier" },
            hurl = { "hurlfmt" },
            python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
            proto = { "buf" },
            ["_"] = { lsp_format = "first" },
            ["*"] = { "trim_whitespace", "trim_newlines" }
        },
        -- Set up format-on-save
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        formatters = {
            hurlfmt = {
                inherit = false,
                command = "hurlfmt",
                stdin = true,
                args = { "--no-color" },
            }
        },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
