return {
    "gbprod/yanky.nvim",
    keys = {
        { "p",  mode = { "n", "x" } },
        { "P",  mode = { "n", "x" } },
        { "gp", mode = { "n", "x" } },
        { "gP", mode = { "n", "x" } },
    },
    config = function()
        require("yanky").setup({})
        vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
        vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
        vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
        vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
        vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
        vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

        require("telescope").load_extension("yank_history")
    end
}
