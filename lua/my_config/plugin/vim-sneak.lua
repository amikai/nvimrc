local M = {}

local g = vim.g
local km = require("my_config.utils").km

function M.setup()
    g["sneak#label"] = 1
    km("", "f", "<Plug>Sneak_s")
    km("", "F", "<Plug>Sneak_S")
end

return M
