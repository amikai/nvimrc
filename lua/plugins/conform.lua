local pack = require("my_config.pack")
local km = require("my_config.utils").km_factory({ silent = true })

pack.add({ pack.gh("stevearc/conform.nvim") })

require("conform").setup({
    -- Define your formatters
    log_level = vim.log.levels.DEBUG,
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
        rust = { "rustfmt" },
        markdown = { "prettier" },
        -- for frontend dev
        -- the fast alternative tool is biome
        javascript = { "prettier" },
        javascriptreact = { "prettier" }, -- jsx
        typescript = { "prettier" },
        typescriptreact = { "prettier" }, -- tsx
        -- ["*"] = { "trim_whitespace", "trim_newlines" }
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
})

km("", "<F3>", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end)

-- If you want the formatexpr, here is the place to set it
-- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
