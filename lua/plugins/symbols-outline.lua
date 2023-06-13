return {
    {
        "simrat39/symbols-outline.nvim",
        opts = {
            autofold_depth = 1,
            keymaps = { -- These keymaps can be a string or a table for multiple keys
                close = { "<Esc>", "q" },
                goto_location = "<Cr>",
                focus_location = "o",
                hover_symbol = "K",
                toggle_preview = "p",
                fold = "zc",
                unfold = "zo",
                fold_all = "zR",
                unfold_all = "zM",
                fold_reset = "R",
            },
        },
        keys = {
            { "<F8>", "<cmd>SymbolsOutline<cr>", mode = "n" },
        },
        config = function(_, opts)
            require("symbols-outline").setup(opts)
        end,
    },
}
