local M = {}

local km = require("my_config.utils").km

function M.setup()
    km("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
    km("n", "<leader>lg", "<cmd>Telescope live_grep<cr>")
end

function M.config()
    require('telescope').setup {
        defaults = {
            file_ignore_patterns = {
                "node_modules",
                "vendor"
            }
        },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            }
        }
    }
    require('telescope').load_extension('fzf')
end

return M
