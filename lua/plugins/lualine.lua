local pack = require("my_config.pack")

pack.add({ pack.gh("nvim-lualine/lualine.nvim") })

require("lualine").setup({
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diagnostics" },
        lualine_c = { "%f" },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    extensions = {
        "nvim-tree",
        "quickfix",
        "fugitive",
        "aerial",
        "man",
    },
    options = {
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
    },
})
