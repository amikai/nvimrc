local M = {}

local g = vim.g
local echo = vim.api.nvim_echo
local km = require('my_config.utils').km

function M.setup()
    km('', '<F2>', '<cmd>Goyo<cr>', {silent = true, noremap = true})
end

return M
