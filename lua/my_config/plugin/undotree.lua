local M = {}

local km = require("my_config.utils").km

function M.setup()
    km("n", "<F6>", "<cmd>UndotreeToggle<cr>")
end

return M
