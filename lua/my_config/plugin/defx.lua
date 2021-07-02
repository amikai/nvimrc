local M = {}

local g = vim.g
local echo = vim.api.nvim_echo
local km = require('my_config.utils').km
local b_km = require('my_config.utils').b_km
local autocmd = require('my_config.utils').autocmd
local fn = vim.fn

function M.setup()
    autocmd('MyAutoCmd', [[BufLeave,BufWinLeave  \[defx\]* call defx#call_action('add_session')]], false)
    km('', '<F4>', '<cmd>Defx -session-file="/tmp/defx_session" -buffer-name="defx"<CR>', {noremap = true})
    autocmd('MyAutocmd', [[FileType defx call my_config#defx#keymapping()]], false)
end

function M.config()
    fn['my_config#defx#basic_setting']()
end

return M
