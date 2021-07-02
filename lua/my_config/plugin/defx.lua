local M = {}

local g = vim.g
local km = require('my_config.utils').km
local autocmd = require('my_config.utils').autocmd
local execute = vim.api.nvim_command
local fn = vim.fn

function M.setup()
    autocmd('MyAutoCmd', [[BufLeave,BufWinLeave  \[defx\]* call defx#call_action('add_session')]])
    autocmd('MyAutocmd', [[FileType defx call my_config#defx#keymapping()]])
    km('', '<F4>', '<cmd>Defx -session-file="/tmp/defx_session" -buffer-name="defx"<CR>', {noremap = true})
end

function M.config()
    execute 'hi link Defx_filename_directory GreenSign'
    fn['my_config#defx#basic_setting']()
end

return M
