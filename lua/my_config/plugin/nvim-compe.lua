local M = {}

local fn = vim.fn
local km = require('my_config.utils').km
local is_load = require('my_config.utils').is_load

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
    elseif is_load('vim-vsnip') and fn['vsnip#jumpable'](1) == 1 then
        return t "<Plug>(vsnip-jump-next)"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end



_G.s_tab_complete = function()
    if fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif is_load('vim-vsnip') and fn['vsnip#jumpable'](-1) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

_G.enter_key = function()
    if fn.pumvisible() == 1 then
        return fn['compe#confirm']('<cr>')
    elseif fn['delimitMate#WithinEmptyPair']() == 1 then
        return  "<C-R>=delimitMate#ExpandReturn()<CR>"
    else
        return t "<CR><Plug>DiscretionaryEnd"
    end
end

function M.config()
    require'compe'.setup {
        autocomplete = false,
        source = {
            path = true,
            buffer = true,
            nvim_lsp = true,
            nvim_lua = true,
            vsnip = true
        }
    }

    km({'i', 's'}, "<Tab>", "v:lua.tab_complete()", {expr = true})
    km({'i', 's'}, "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
    km("i", "<cr>", "v:lua.enter_key()", {expr = true})
end

return M
