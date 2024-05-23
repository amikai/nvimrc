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
                    require("go.format").goimports()
                end,
                group = format_sync_grp,
            })

            require("go").setup({
                lsp_cfg = false,
                goimports = "goimports",
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
                lsp_keymaps = function(bufnr)
                    local keymaps = {
                        { key = 'gd',        func = vim.lsp.buf.definition,           desc = 'goto definition' },
                        { key = 'gi',        func = vim.lsp.buf.implementation,       desc = 'goto implementation' },
                        { key = '<C-k>',     func = vim.lsp.buf.signature_help,       desc = 'signature help' },
                        { key = '<space>wa', func = vim.lsp.buf.add_workspace_folder, desc = 'add workspace' },
                        {
                            key = '<space>wr',
                            func = vim.lsp.buf.remove_workspace_folder,
                            desc = 'remove workspace',
                        },
                        {
                            key = '<space>wl',
                            func = function()
                                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                            end,
                            desc = 'list workspace',
                        },
                        { key = 'gD',   func = vim.lsp.buf.type_definition,    desc = 'goto type definition' },
                        { key = 'gR',   func = vim.lsp.buf.rename,             desc = 'rename' },
                        { key = 'gr',   func = vim.lsp.buf.references,         desc = 'references' },
                        { key = '<F9>', func = vim.diagnostic.open_float,      desc = 'diagnostic' },
                        { key = '<F3>', func = require("go.format").goimports, desc = 'format' },
                    }

                    local km = require("my_config.utils").km_factory({ silent = true, buffer = bufnr })
                    for _, keymap in pairs(keymaps) do
                        km(keymap.mode or 'n', keymap.key, keymap.func)
                    end
                end,
                lsp_inlay_hints = {
                    enable = false,
                },
                trouble = false,
            })

            local cfg = require 'go.lsp'.config() -- config() return the go.nvim gopls setup
            require('lspconfig').gopls.setup(cfg)

            local golangci_lint = require("go.null_ls").golangci_lint().with({
                filter = function(diagnostic)
                    -- According https://github.com/golangci/golangci-lint/issues/2912,
                    -- It's not possible to disable typecheck. So filter it manually.
                    if diagnostic.source:match("typecheck") then
                        return false
                    end
                    return true
                end, -- See https://golangci-lint.run/usage/linters
                extra_args = {
                    "--no-config",
                    "--disable-all",
                    -- default option of golangci_lint
                    "-E", "gosimple",
                    "-E", "errcheck",
                    "-E", "govet",
                    "-E", "ineffassign",
                    "-E", "staticcheck",
                    -- others
                    "-E", "revive",
                    "-E", "bodyclose",
                    "-E", "prealloc",
                    "-E", "nestif",
                    "-E", "nilerr",
                    "-E", "nilnil",
                    -- logger check
                    "-E", "sloglint",
                    "-E", "loggercheck",
                    -- lint prometheus metrics name
                    "-E", "promlinter",
                    -- lint the usage of testify
                    "-E", "testifylint",
                },
            })

            require("null-ls").register(golangci_lint)
        end,
    },
}
