local M = {}

local g = vim.g

function M.config()
    require("nvim-treesitter.install").prefer_git = true
    require("nvim-treesitter.configs").setup({
        additional_vim_regex_highlighting = false,
        ensure_installed = {
            "c",
            "rust",
            "cpp",
            "make",
            "cmake",
            "bash",
            "go",
            "gomod",
            "gowork",
            "html",
            "javascript",
            "css",
            "scss",
            "yaml",
            "json",
            "toml",
            "dockerfile",
            "python",
            "vim",
            "lua",
            "proto",
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            disable = { "python" },
        },
        -- Indentation based on treesitter for the = operator
        indent = {
            enable = true,
        },
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
        matchup = {
            enable = true,
        },
        rainbow = {
            enable = true,
            extended_mode = false,
            max_file_lines = 1000,
        },
        endwise = {
            enable = true,
        },
    })
end

return M
