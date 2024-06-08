return {
    {
        "ray-x/go.nvim",
        ft = { "go", 'gomod' },
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
            "folke/trouble.nvim",
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
        end,
    },
}
