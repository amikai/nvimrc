local M = {}

local km = require('my_config.utils').km

function M.setup()
    km('n', '<F1>','<cmd>ToggleTerm<cr>')
    km('t', '<F1>','<cmd>ToggleTerm<cr>')
end

return M
