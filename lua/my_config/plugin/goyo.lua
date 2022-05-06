local M = {}

local g = vim.g
local echo = vim.api.nvim_echo
local km = vim.keymap.set

function M.setup()
    km('', '<F2>', '<cmd>Goyo<cr>')
end

return M
