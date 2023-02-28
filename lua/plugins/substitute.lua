return {
    {
        "gbprod/substitute.nvim",
        keys = {
            { "R",  "<cmd>lua require('substitute').operator()<cr>",          mode = { "n", "x" } },
            { "RR", "<cmd>lua require('substitute').line()<cr>",              mode = { "n" } },
            { "cx", "<cmd>lua require('substitute.exchange').operator()<cr>", mode = { "n" } },
        },
        config = function()
            require("substitute").setup({})
        end
    },
}
