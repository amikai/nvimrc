return {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", mode = { "n" } },
            { "<leader>lg", "<cmd>Telescope live_grep<cr>",  mode = { "n" } },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = {
                        "node_modules",
                        "vendor",
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    },
                },
            })
            require("telescope").load_extension("fzf")
        end,
    },
}
