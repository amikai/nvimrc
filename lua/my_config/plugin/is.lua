local M = {}

local g = vim.g
local echo = vim.api.nvim_echo
local km = require('my_config.utils').km

function M.setup()
    g['asterisk#keeppos'] = 1
    km('', '*', '<Plug>(asterisk-z*)<Plug>(is-nohl-1)')
    km('', '#', '<Plug>(asterisk-z#)<Plug>(is-nohl-1)')
    km('', 'g*', '<Plug>(asterisk-gz*)<Plug>(is-nohl-1)')
    km('', 'g#', '<Plug>(asterisk-gz#)<Plug>(is-nohl-1)')
end

return M
