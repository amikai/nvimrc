local M = {}

local g = vim.g
local fn = vim.fn
local km = require('my_config.utils').km

function M.config()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            "c", "rust",  "cpp", "cmake", "bash",
            "go", "gomod", "gowork",
            "html", "javascript", "css", "scss",
            "yaml", "json", "toml",
            "dockerfile",
            "python",
            "vim",
            "lua",
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            disable = {"python"}
        },
        indent = {
            endble = true
        },
        matchup = {
            enable = true
        },
        additional_vim_regex_highlighting = false,
    }
end

return M
