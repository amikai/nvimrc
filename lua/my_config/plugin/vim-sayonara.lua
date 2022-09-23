local M = {}

local g = vim.g
local km = require("my_config.utils").km

function M.setup()
    g.sayonara_filetypes = {
        tagbar = "TagbarClose",
    }

    km("n", "<leader>c", "<cmd>Sayonara!<cr>")
    km("n", "<leader>q", "<cmd>Sayonara<cr>")
end

return M
