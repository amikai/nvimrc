local M = {}

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
    else
        return fn['ddc#manual_complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    else
        return t "<C-h>"
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

M.config = function()
    fn['ddc#custom#patch_global']('sources', {'nvim-lsp','around'})
    fn['ddc#custom#patch_global']('sourceOptions', {
        _ = {
            matchers = {'matcher_head', 'matcher_length'},
            sorters = {'sorter_rank'},
            converters = {'converter_remove_overlap'}
        },
        ['nvim-lsp'] = { mark = 'LSP' },
        around = { mark = 'A'},
    })
    km('i', '<tab>', 'v:lua.tab_complete()' ,{expr = true, silent = true, noremap = true})
    km('i', '<s-tab>', '<C-R>=v:lua.s_tab_complete()<CR>' ,{silent = true, noremap = true})
    km('i', '<enter>', 'v:lua.enter_key()' ,{expr = true, noremap = false})
    fn['ddc#enable']()
end


return M
