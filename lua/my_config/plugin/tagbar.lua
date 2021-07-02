local M = {}

local g = vim.g
local echo = vim.api.nvim_echo
local km = require('my_config.utils').km

function M.setup()
    km('n', '<F8>', '<cmd>TagbarToggle<cr>', {noremap = true})
    g.tagbar_sort = 0
    g.tagbar_type_go = {
        ctagstype = 'go',
        kinds = {
            'p:package',
            'i:imports:1',
            'c:constants',
            'v:variables',
            't:types',
            'n:interfaces',
            'w:fields',
            'e:embedded',
            'm:methods',
            'r:constructor',
            'f:functions'
        },
        sro = '.',
        kind2scope = {
            t = 'ctype',
            n = 'ntype',
        },
        scope2kind = {
            ctype = 't',
            ntype = 'n'
        },
        ctagsbin  = 'gotags',
        ctagsargs = '-sort -silent'
    }
end

return M
