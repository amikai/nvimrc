local M = {}

local km = vim.keymap.set

function M.setup()
    km('n', '<leader>ff','<cmd>Telescope find_files<cr>')
    km('n', '<leader>lg', '<cmd>Telescope live_grep<cr>')
end

return M
