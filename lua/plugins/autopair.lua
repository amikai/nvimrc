return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
            -- TODO: integrate into blink.cmp
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require('nvim-ts-autotag').setup({
                opts = {
                    -- Defaults
                    enable_close = true,          -- Auto close tags
                    enable_rename = true,         -- Auto rename pairs of tags
                    enable_close_on_slash = false -- Auto close on trailing </
                },
            })
        end
    }

}
