local M = {}

local g = vim.g
local km = require("my_config.utils").km_factory({ silent = true, buffer = true })
local autocmd = vim.api.nvim_create_autocmd

function M.setup()
    g.go_gopls_gofumpt = true
    g.go_metalinter_command = "golangci-lint"
    g.go_metalinter_enabled = { "vet", "errcheck", "staticcheck", "gosimple" }
    g.go_metalinter_autosave_enabled = { "vet", "errcheck", "staticcheck", "gosimple" }
    g.go_metalinter_autosave = 0
    g.go_jump_to_error = 0
    g.go_echo_go_info = 0
    g.go_auto_type_info = 1
    g.go_fmt_command = "gopls"
    g.go_fmt_autosave = 1
    g.go_guru_scope = { "..." }
    g.go_highlight_function_calls = 1
    g.go_def_mapping_enabled = 0
    g.go_code_completion_enabled = 0

    autocmd("FileType", {
        pattern = "go",
        callback = function()
            km("n", "gR", "<Plug>(go-rename)")
            km("n", "gd", "<Plug>(go-def)")
            km("n", "gD", "<Plug>(go-describe)")
            km("n", "gr", "<Plug>(go-referrers)")
            km("n", "gR", "<Plug>(go-rename)")
            km("n", "gi", "<Plug>(go-implements)")
            km("n", "gt", "<Plug>(go-def-type)")
            km("n", "<F3>", "<Plug>(go-fmt)")
        end,
    })
end

return M
