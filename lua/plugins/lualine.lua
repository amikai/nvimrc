return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diagnostics' },
                    lualine_c = { '%f' },
                    lualine_x = { 'encoding', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                extensions = {
                    "nvim-tree",
                    "quickfix",
                    "toggleterm",
                    "fugitive",
                    "aerial",
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
