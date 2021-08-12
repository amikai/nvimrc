local M = {}

local g = vim.g
local km = require('my_config.utils').km
local fn = vim.fn
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = fn.col('.') - 1
    if col == 0 or fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    end
end

_G.enter_key = function()
    if fn.pumvisible() == 1 then
        return t "<C-y>"
    elseif fn['delimitMate#WithinEmptyPair']() == 1 then
        return t "<C-R>=delimitMate#ExpandReturn()<CR>"
    else
        return t "<CR><Plug>DiscretionaryEnd"
    end
end

function M.setup()
    g['ycm_auto_trigger'] = 1
    g['ycm_key_list_select_completion'] = {}
    g['ycm_key_list_previous_completion'] = {}
end

function M.config()
    km('i', '<tab>', '<C-R>=v:lua.tab_complete()<CR>' ,{silent = true, noremap = true})
    km('i', '<s-tab>', '<C-R>=v:lua.s_tab_complete()<CR>' ,{silent = true, noremap = true})
    km('i', '<enter>', 'v:lua.enter_key()' ,{expr = true, noremap = false})
end

return M
