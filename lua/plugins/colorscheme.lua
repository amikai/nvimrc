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
            vim.cmd [[colorscheme iceberg]]
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
}
