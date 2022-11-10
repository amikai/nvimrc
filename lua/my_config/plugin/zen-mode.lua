local M = {}

local km = require("my_config.utils").km

function M.setup()
    km("n", "<F2>", "<cmd>ZenMode<cr>")
end

function M.config()
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
    })
end

return M
