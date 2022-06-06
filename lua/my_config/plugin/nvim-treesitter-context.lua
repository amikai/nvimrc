local M = {}

function M.config()
    require'treesitter-context'.setup{
        enable = true,
    }
end

return M
