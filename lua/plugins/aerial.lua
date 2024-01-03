return {
    {
        'stevearc/aerial.nvim',
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        keys = {
            { "<F8>", "<cmd>AerialToggle<cr>", mode = "n" },
        },
        config = function()
            require("aerial").setup({})
        end
    },
}
