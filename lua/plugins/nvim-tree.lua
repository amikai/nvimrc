return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    cmd = "NvimTreeToggle",
    keys = {
        { "<F4>", "<cmd>NvimTreeToggle<cr>", mode = "n", { silent = true } },
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {
            git = {
                enable = false,
            }
        }
    end,
}
