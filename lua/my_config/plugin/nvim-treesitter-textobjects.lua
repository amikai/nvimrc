local M = {}

local g = vim.g

function M.config(test)
    require 'nvim-treesitter.configs'.setup {
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["i,"] = "@parameter.inner",
                    ["a,"] = "@parameter.outer",
                    ["ac"] = "@comment.outer",
                },
                include_surrounding_whitespace = true,
            },
        },
    }
end

return M
