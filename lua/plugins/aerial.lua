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
            require("aerial").setup({
                layout = {
                    min_width = 25,
                    max_width = 25,

                },
                nerd_font = false,
            })
        end
    },
}
