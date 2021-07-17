local M = {}
local km = require('my_config.utils').km

function M.setup()
    vim.g.choosewin_overlay_enable = 1
    km('n', 'W', '<Plug>(choosewin)', {noremap = false})
end

return M
