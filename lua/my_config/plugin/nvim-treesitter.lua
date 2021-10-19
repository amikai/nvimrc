local M = {}

local g = vim.g
local fn = vim.fn
local km = require('my_config.utils').km

function M.config()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            "c", "rust",  "cpp", "cmake", "bash",
            "go", "gomod",
            "html", "javascript", "css", "scss",
            "yaml", "json", "toml",
            "dockerfile",
            "vim",
            "lua",
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            endble = true
        },
    }
end

return M
