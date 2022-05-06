local M = {}

local g = vim.g
local km = vim.keymap.set

function M.setup()
    g.quickr_cscope_keymaps = 0
    km('n', '<C-s>s','<Plug>(quickr_cscope_symbols)')
    km('n', '<C-s>g', '<Plug>(quickr_cscope_global)')
    km('n', '<C-s>c', '<Plug>(quickr_cscope_callers)')
    km('n', '<C-s>f', '<Plug>(quickr_cscope_files)')
    km('n', '<C-s>i', '<Plug>(quickr_cscope_includes)')
    km('n', '<C-s>t', '<Plug>(quickr_cscope_text)')
    km('n', '<C-s>e', '<Plug>(quickr_cscope_egrep)')
    km('n', '<C-s>d', '<Plug>(quickr_cscope_functions)')
end

return M
