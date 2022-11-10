local M = {}

function M.setup()
    vim.g.delimitMate_expand_space = 1
    vim.g.delimitMate_smart_quotes = 1
    vim.g.delimitMate_nesting_quotes = { '"', "'" }
end

return M
