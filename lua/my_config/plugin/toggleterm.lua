local M = {}

local km = vim.keymap.set

function M.setup()
    km('n', '<F1>','<cmd>ToggleTerm<cr>')
    km('t', '<F1>','<cmd>ToggleTerm<cr>')
end

return M
