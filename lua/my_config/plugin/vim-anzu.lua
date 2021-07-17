local M = {}

local g = vim.g
local echo = vim.api.nvim_echo
local km = require('my_config.utils').km

function M.setup()
    km('', 'n', '<Plug>(is-nohl)<Plug>(anzu-n-with-echo)zzzv')
    km('', 'N', '<Plug>(is-nohl)<Plug>(anzu-N-with-echo)zzzv')
    -- km('', 'n', '<Plug>(anzu-mode-n)', {})
    -- km('', 'N', '<Plug>(anzu-mode-N)', {})
end

return M
