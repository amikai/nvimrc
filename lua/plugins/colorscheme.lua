local pack = require("my_config.pack")
local gh = pack.gh

vim.g.vscode_style = "dark"

pack.add({
    gh("arcticicestudio/nord-vim"),
    gh("cocopon/iceberg.vim"),
    gh("Mofiqul/vscode.nvim"),
    -- lush.nvim allows for more configuration or extending zenbones
    gh("rktjmp/lush.nvim"),
    gh("mcchrish/zenbones.nvim"),
    gh("EdenEast/nightfox.nvim"),
    { src = gh("catppuccin/nvim"), name = "catppuccin" },
})

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {
        light = "latte",
        dark = "mocha",
    },
    integrations = {
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

vim.cmd([[colorscheme iceberg]])
