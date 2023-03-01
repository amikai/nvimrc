return {
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        keys = {
            { "<F2>", "<cmd>ZenMode<cr>", mode = "n" },
        },
        config = function()
            require("zen-mode").setup({
                window = {
                    backdrop = 0.8, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
                    width = 100,
                    options = {
                        -- signcolumn = "no", -- disable signcolumn
                        -- number = false, -- disable number column
                        -- relativenumber = false, -- disable relative numbers
                        cursorline = false, -- disable cursorline
                        cursorcolumn = false, -- disable cursor column
                        foldcolumn = "0", -- disable fold column
                        list = false, -- disable whitespace characters
                    },
                },
                plugins = {
                    twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
                },
            })
        end,
    },
    {
        "folke/twilight.nvim",
        keys = {
            { "<F50>", "<cmd>Twilight<cr>", mode = "n" },
        },
        cmd = "Twilight",
        dependencies = "nvim-treesitter",
        config = function()
            require("twilight").setup({
                dimming = {
                    alpha = 0.25, -- amount of dimming
                    -- we try to get the foreground from the highlight groups or fallback color
                    color = { "Normal", "#ffffff" },
                    term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
                    inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
                },
                context = 10, -- amount of lines we will try to show around the current line
                treesitter = true, -- use treesitter when available for the filetype
                -- treesitter is used to automatically expand the visible text,
                -- but you can further control the types of nodes that should always be fully expanded
                expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
                    "function",
                    "method",
                },
                exclude = {}, -- exclude these filetypes
            })
        end,
    },
}
