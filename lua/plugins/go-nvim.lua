return {
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
            "folke/trouble.nvim",
            "jose-elias-alvarez/null-ls.nvim",
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
                lsp_cfg = true,
                goimport = "goimports",
                gofmt = "gofumpt",
                lsp_codelens = false,
                lsp_gofumpt = true,
                lsp_diag_virtual_text = { space = 0, prefix = "" },
                lsp_diag_signs = true,
                lsp_inlay_hints = {
                    enable = true,
                },
                lsp_keymaps = function()
                    local km = require("my_config.utils").km_factory({ silent = true })

                    km("n", "gd", vim.lsp.buf.definition)
                    km("n", "K", vim.lsp.buf.hover)
                    -- km("n", "<C-k>", vim.lsp.buf.signature_help)
                    km("n", "gR", vim.lsp.buf.rename)
                    km("n", "gr", vim.lsp.buf.references)
                    km("n", "[d", vim.diagnostic.goto_prev)
                    km("n", "]d", vim.diagnostic.goto_next)
                    km("n", "gi", vim.lsp.buf.implementation)
                    km("n", "gt", vim.lsp.buf.type_definition)
                    km("n", "gD", vim.lsp.buf.declaration)

                    km("n", "<leader>ca", vim.lsp.buf.code_action)
                    km("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
                    km("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
                    km("n", "<leader>wl", function()
                        vim.pretty_print(vim.lsp.buf.list_workspace_folders())
                    end)

                    km("n", "<F3>", require("go.format").goimport)
                end,
                trouble = false,
            })

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
