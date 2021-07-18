local M = {}

local g = vim.g
local autocmd = require('my_config.utils').autocmd

function M.setup()
    g.ale_completion_enabled = 0
    g.ale_fix_on_save = 0
    g.ale_set_quickfix = 0
    g.ale_set_loclist = 1

    g.ale_sign_error = 'E'
    g.ale_sign_warning = 'W'
    g.ale_sign_info = 'I'

    g.ale_lint_on_text_changed = 1
    g.ale_lint_delay = 500
    g.ale_lint_on_insert_leave = 1
    g.ale_history_enabled = 0
    g.ale_virtualtext_cursor = 1
end

function M.config()
end


return M