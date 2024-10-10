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
                lsp_cfg = true,
                lsp_codelens = false,
                lsp_gofumpt = true,
                diagnostic = {
                    underline = true,
                    virtual_text = true,
                    sign = true,
                    float = {
                        format = function(diagnostic)
                            return diagnostic.message
                        end,
                        suffix = function(diagnostic)
                            return string.format(" [%s]", diagnostic.source), ""
                        end,
                    },
                },
                luasnip = true,
                lsp_keymaps = function(bufnr)
                    local km = require("my_config.utils").km_factory({ silent = true, buffer = bufnr })
                    local lsp_zero = require('lsp-zero')

                    km('n', 'gR', "<cmd>GoRename<cr>")
                    km("n", "<leader>ca", vim.lsp.buf.code_action)
                    km("n", "<leader>wl", function()
                        vim.pretty_print(vim.lsp.buf.list_workspace_folders())
                    end)
                    lsp_zero.default_keymaps({
                        buffer = bufnr,
                        -- When set to preserve_mappings to true,lsp-zero will not
                        -- override your existing keybindings.
                        preserve_mappings = true
                    })
                end,
                gopls_cmd = { require('mason.settings').current.install_root_dir .. "/bin/gopls" },
                lsp_inlay_hints = {
                    enable = false,
                },
                trouble = false,
            })
        end,
    },
}
