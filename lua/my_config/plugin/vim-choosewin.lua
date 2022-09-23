local M = {}
local km = vim.keymap.set

function M.setup()
    vim.g.choosewin_overlay_enable = 1
    km("n", "W", "<Plug>(choosewin)")
end

return M
