local M = {}

local km = require('my_config.utils').km

function M.setup()
    km('n', '<F6>', '<cmd>UndotreeToggle<cr>', {silent = true, noremap = true})
end

return M
