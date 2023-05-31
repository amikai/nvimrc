return {
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        cmd = { "Trouble", "TroubleClose", "TroubleToggle" },
        keys = {
            { "<F9>", "<cmd>TroubleToggle document_diagnostics<cr>", mode = "n" },
        },
        config = function()
            local km = require("my_config.utils").km

            require("trouble").setup()
            km(
                "n",
                "[d",
                "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<CR>",
                { silent = true }
            )

            km("n", "]d", "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<CR>", { silent = true })
        end,
    },
}
