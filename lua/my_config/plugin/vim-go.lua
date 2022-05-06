local M = {}

local b = vim.b

function M.setup()
    -- b.go_metalinter_command = "golangci-lint"
    -- b.go_metalinter_enabled = {'vet', 'errcheck', 'staticcheck', 'gosimple'}
    -- b.go_metalinter_autosave_enabled = {'vet', 'errcheck', 'staticcheck', 'gosimple'}
    -- b.go_metalinter_autosave = 0
    -- b.go_jump_to_error = 0
    -- b.go_echo_go_info = 0
    -- b.go_auto_type_info = 1
    -- b.go_fmt_command = "gopls"
    -- b.go_fmt_autosave = 1
    -- b.go_guru_scope = {"..."}
    -- b.go_highlight_function_calls = 1
    -- b.go_def_mapping_enabled = 0
    -- b.go_code_completion_enabled = 0

    -- vim.g.go_gopls_gofumpt=true
    vim.api.nvim_buf_set_keymap(0, "n", "gR", "<Plug>(go-rename)", { noremap = false, silent = true })
    vim.cmd([[
    augroup MyGoSetting
        autocmd!
        autocmd FileType go let b:go_metalinter_command = "golangci-lint"
        autocmd FileType go let b:go_metalinter_enabled = ['vet', 'errcheck', 'staticcheck', 'gosimple']
        autocmd FileType go let b:go_metalinter_autosave_enabled = ['vet', 'errcheck', 'staticcheck', 'gosimple']
        autocmd FileType go let b:go_metalinter_autosave = 0
        autocmd FileType go let b:go_jump_to_error = 0
        autocmd FileType go let b:go_echo_go_info = 0
        autocmd FileType go let b:go_auto_type_info = 1
        autocmd FileType go let b:go_fmt_command = "gopls"
        autocmd FileType go let b:go_fmt_autosave = 1
        autocmd FileType go let b:go_guru_scope = ["..."]
        autocmd FileType go let b:go_highlight_function_calls = 1
        autocmd FileType go let b:go_def_mapping_enabled = 0
        autocmd FileType go let b:go_code_completion_enabled = 0

        autocmd FileType go nmap <buffer>gd <Plug>(go-def)
        autocmd FileType go nmap <buffer>gD <Plug>(go-describe)
        autocmd FileType go nmap <buffer>gr <Plug>(go-referrers)
        autocmd FileType go nmap <buffer>gR <Plug>(go-rename)
        autocmd FileType go nmap <buffer>gi <Plug>(go-implements)
        autocmd FileType go nmap <buffer>gt <Plug>(go-def-type)

        autocmd FileType go nmap <buffer><leader>gm <Plug>(go-metalinter)
        autocmd FileType go nmap <buffer><f3> <Plug>(go-fmt)
        autocmd FileType go nmap <buffer><f16> <Plug>(go-test)
        autocmd FileType go nmap <buffer><f17> <Plug>(go-build)
        autocmd FileType go nmap <buffer><f18> <Plug>(go-run)
    augroup END
    ]])
end

return M
