return {

    {
        "akinsho/toggleterm.nvim",
        cmd = 'ToggleTerm',
        keys = {
            { "<F1>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" } }
        },
        config = function()
            require("toggleterm").setup()
        end
    },
}
