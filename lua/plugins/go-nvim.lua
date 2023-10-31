return {
    {
        "ray-x/go.nvim",
        ft = { "go", 'gomod' },
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
            "folke/trouble.nvim",
            "null-ls",
            -- for debugging
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
        },
        build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
        config = function()
            local format_sync_grp = vim.api.nvim_create_augroup("GoImport", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    require("go.format").goimport()
                end,
                group = format_sync_grp,
            })

            require("go").setup({
                goimport = "goimports",
                gofmt = "gofumpt",
                lsp_codelens = false,
                lsp_gofumpt = true,
                luasnip = true,
                diagnostic = {
                    -- set diagnostic to false to disable vim.diagnostic setup
                    hdlr = false, -- hook lsp diag handler
                    underline = true,
                    -- virtual text setup
                    virtual_text = { space = 0, prefix = '■' },
                    signs = true,
                    update_in_insert = false,
                },
                -- lsp keybinding is delegate to lspzero
                lsp_keymaps = false,
                lsp_inlay_hints = {
                    enable = false,
                },
                trouble = false,
            })

            local km = require("my_config.utils").km_factory({ silent = true })
            local golangci_lint = require("go.null_ls").golangci_lint().with({
                filter = function(diagnostic)
                    -- Accroding https://github.com/golangci/golangci-lint/issues/2912,
                    -- It's not possible to disable typecheck. So filter it manually.
                    if diagnostic.source:match("typecheck") then
                        return false
                    end
                    return true
                end,
                -- See https://golangci-lint.run/usage/linters
                -- TODO: convert following args to config file
                extra_args = {
                    "--disable-all",
                    -- defualt option of golangci_lint
                    "-E", "gosimple",
                    "-E", "errcheck",
                    "-E", "govet",
                    "-E", "ineffassign",
                    "-E", "staticcheck",
                    -- others
                    "-E", "revive",
                    "-E", "bodyclose",
                },
            })

            require("null-ls").register(golangci_lint)
        end,
    },
}
