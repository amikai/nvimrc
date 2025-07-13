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
                gopls_cmd = { require('mason.settings').current.install_root_dir .. "/bin/gopls" },
                lsp_inlay_hints = {
                    enable = false,
                },
                trouble = false,
            })
        end,
    },
}
