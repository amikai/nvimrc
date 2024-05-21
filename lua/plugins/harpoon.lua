return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader><leader>", [[ <cmd>lua require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())<cr> ]], mode = "n", { silent = true } },
            { "<leader>a", [[ <cmd>lua require("harpoon"):list():add()<cr> ]], mode = "n", { silent = true } },
            { "[h", [[ <cmd>lua require("harpoon"):list():prev()<cr> ]], mode = "n", { silent = true } },
            { "]h", [[ <cmd>lua require("harpoon"):list():next()<cr> ]], mode = "n", { silent = true } },
        },
    },
}
