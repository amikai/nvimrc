return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                sections = {
                    lualine_a = {'%f'},
                    lualine_b = {'branch'},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                extensions = {
                    "nvim-tree",
                    "quickfix",
                    "toggleterm",
                    "fugitive",
                    "symbols-outline",
                    "trouble",
                    "lazy",
                    "man",
                },
            })
        end,
    },
}
