local M = {}

function M.config()
    require'treesitter-context.config'.setup{
        enable = true,
    }
end

return M
