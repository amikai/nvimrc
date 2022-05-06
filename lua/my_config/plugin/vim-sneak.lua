local M = {}

local g = vim.g
local km = vim.keymap.set

function M.setup()
    g['sneak#label'] = 1
    km('', 'f', '<Plug>Sneak_s')
    km('', 'F', '<Plug>Sneak_S')
end

return M
