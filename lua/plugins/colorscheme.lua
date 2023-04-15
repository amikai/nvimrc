return {
    {
        "arcticicestudio/nord-vim",
        lazy = true,
        config = function()
            -- vim.cmd[[colorscheme nord]]
        end,
    },
    {
        "cocopon/iceberg.vim",
        config = function()
            vim.cmd([[colorscheme iceberg]])
        end,
    },
    {
        "Mofiqul/vscode.nvim",
        lazy = true,
        init = function()
            vim.g.vscode_style = "dark"
        end,
        config = function()
            -- vim.cmd([[colorscheme vscode]])
        end,
    },
    {
        "mcchrish/zenbones.nvim",
        -- Optionally install Lush. Allows for more configuration or extending the colorscheme
        -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
        -- In Vim, compat mode is turned on as Lush only works in Neovim.
        dependencies = "rktjmp/lush.nvim"
    },
    { "EdenEast/nightfox.nvim" },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    notify = false,
                    mini = false,
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
            })
        end
    },
}
