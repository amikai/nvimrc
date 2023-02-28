return {
    {
        "simrat39/symbols-outline.nvim",
        opts = {
            autofold_depth = 1,
        },
        keys = {
            { "<F8>", "<cmd>SymbolsOutline<cr>", mode = "n" }
        },
        config = function(_, opts)
            require("symbols-outline").setup(opts)
        end,
    },
}
