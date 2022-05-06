local M = {}

local g = vim.g
local km = vim.keymap.set

function M.setup()
    g.signify_priority = 5
    km('x', 'ic', '<plug>(signify-motion-inner-visual)')
    km('o', 'ic', '<plug>(signify-motion-inner-pending)')
    km('x', 'ac', '<plug>(signify-motion-outer-visual)')
    km('o', 'ac', '<plug>(signify-motion-outer-pending)')
    km('n', ']c', '<plug>(signify-next-hunk)')
    km('n', '[c', '<plug>(signify-prev-hunk)')
end

return M
