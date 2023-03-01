return {
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gc", mode = { "n", "x" } },
            { "gcc", mode = "n" },
        },
        config = function()
            require("Comment").setup()
        end,
    },
}
