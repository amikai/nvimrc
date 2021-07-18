local M = {}

local g = vim.g
local echo = vim.api.nvim_echo
local km = require('my_config.utils').km

function M.setup()
    g.airline_extensions = {'tabline', 'quickfix', 'branch', 'fern', 'tagbar'}

    g.airline_powerline_fonts = 1

    g['airline#extensions#tabline#enabled']= 1

    -- show the airline_tab type is tab or buffer (top right)
    g['airline#extensions#tabline#show_tab_type'] = 1

    -- close symbol (top right)
    g['airline#extensions#tabline#close_symbol'] = 'X'

    -- enable displaying buffers with a single tab
    -- it mean airline_tab type is buffer
    g['airline#extensions#tabline#show_buffers'] = 1
    -- Show the buffer order with a single tab
    -- convient to use <leader>n to switch buffer
    g['airline#extensions#tabline#buffer_idx_mode'] = 1

    -- if airline_tab type is tab
    -- convient to use <leader>n to switch tap
    g['airline#extensions#tabline#tab_nr_type'] = 1

    -- disable show split information on top right
    g['airline#extensions#tabline#show_splits'] = 0
end

return M
