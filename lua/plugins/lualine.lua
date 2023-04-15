return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'%f'},
                    lualine_x = {},
                    lualine_y = {'progress'},
                    lualine_z = {'location'},
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
                options = {
                    theme = "auto",
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '', right = '' },
                },
            })
        end,
    },
}
