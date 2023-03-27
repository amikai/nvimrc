return {
    {
        "zbirenbaum/copilot-cmp",
        dependencies = {
            {
                "zbirenbaum/copilot.lua",
                config = function()
                    require("copilot").setup({
                        panel = {
                            enabled = true,
                            auto_refresh = true,
                            layout = {
                                position = "bottom", -- | top | left | right
                                ratio = 0.3,
                            },
                        },
                    })
                end,
            },
        },
        config = function()
            require("copilot_cmp").setup()
        end,
    },
}
