local M = {}

local b = vim.b
local km = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

function M.setup()

    -- vim.g.go_gopls_gofumpt=true
    vim.api.nvim_buf_set_keymap(0, "n", "gR", "<Plug>(go-rename)", { noremap = false, silent = true })
    autocmd("FileType", {
        pattern = "go",
        callback = function()
            b.go_metalinter_command = "golangci-lint"
            b.go_metalinter_enabled = {'vet', 'errcheck', 'staticcheck', 'gosimple'}
            b.go_metalinter_autosave_enabled = {'vet', 'errcheck', 'staticcheck', 'gosimple'}
            b.go_metalinter_autosave = 0
            b.go_jump_to_error = 0
            b.go_echo_go_info = 0
            b.go_auto_type_info = 1
            b.go_fmt_command = "gopls"
            b.go_fmt_autosave = 1
            b.go_guru_scope = {"..."}
            b.go_highlight_function_calls = 1
            b.go_def_mapping_enabled = 0
            b.go_code_completion_enabled = 0

            km('', 'gd', '<Plug>(go-def)', { buffer = true })
            km('', 'gD', '<Plug>(go-describe)', { buffer = true })
            km('', 'gr', '<Plug>(go-referrers)', { buffer = true })
            km('', 'gR', '<Plug>(go-rename)', { buffer = true })
            km('', 'gi', '<Plug>(go-implements)', { buffer = true })
            km('', 'gt', '<Plug>(go-def-type)', { buffer = true })
        end
    })
end

return M
