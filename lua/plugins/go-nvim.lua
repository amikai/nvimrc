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
            require("go").setup({
                lsp_cfg = false,
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
                    -- logger check
                    "-E", "sloglint",
                    "-E", "loggercheck",
                    -- lint prometheus metrics name
                    "-E", "promlinter",
                    -- lint the usage of testify
                    "-E", "testifylint",
                    -- computes the cyclomatic complexity
                    "-E", "gocyclo",
                    -- finds repeated strings that could be replaced by a constant.
                    "-E", "goconst",
                    -- others
                    "-E", "revive",
                    "-E", "bodyclose",
                    "-E", "prealloc",
                    "-E", "nestif",
                    "-E", "nilerr",
                    "-E", "nilnil",
                },
            })

            require("null-ls").register(golangci_lint)
        end,
    },
}
