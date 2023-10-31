return {
    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader><leader>", [[ <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr> ]], mode = "n", { silent = true } },
            { "<leader>a", [[ <cmd>lua require("harpoon.mark").add_file()<cr> ]], mode = "n", { silent = true } },
            { "[h", [[ <cmd>lua require("harpoon.ui").nav_prev()<cr> ]], mode = "n", { silent = true } },
            { "]h", [[ <cmd>lua require("harpoon.ui").nav_next()<cr> ]], mode = "n", { silent = true } },
        },
    },
}
