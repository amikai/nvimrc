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
                lsp_cfg = false,
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
                lsp_keymaps = function(bufnr)
                    keymaps = {
                        { key = 'gd',        func = vim.lsp.buf.definition,           desc = 'goto definition' },
                        { key = 'K',         func = vim.lsp.buf.hover,                desc = 'hover' },
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
                        { key = 'gD',         func = vim.lsp.buf.type_definition,              desc = 'goto type definition' },
                        { key = 'gR',         func = require('go.rename').run,                 desc = 'rename' },
                        { key = '<leader>ca', func = require('go.codeaction').run_code_action, desc = 'code action' },
                        {
                            mode = 'v',
                            key = '<leader>ca',
                            func = require('go.codeaction').run_range_code_action,
                            desc = 'range code action',
                        },
                        { key = 'gr',        func = vim.lsp.buf.references,       desc = 'references' },
                        { key = '<F9>',      func = vim.diagnostic.open_float,    desc = 'diagnostic' },
                        { key = '[d',        func = vim.diagnostic.goto_prev,     desc = 'diagnostic prev' },
                        { key = ']d',        func = vim.diagnostic.goto_next,     desc = 'diagnostic next' },
                        { key = '<leader>q', func = vim.diagnostic.setloclist,    desc = 'diagnostic loclist' },
                        { key = '<F3>',      func = require("go.format").goimpor, desc = 'format' },
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
                    "-E", "prealloc",

                    "-E", "sloglint",
                    "-E", "loggercheck",
                },
            })

            require("null-ls").register(golangci_lint)
        end,
    },
}
