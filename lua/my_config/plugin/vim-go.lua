local M = {}

local g = vim.g
local autocmd = require('my_config.utils').autocmd

function M.setup()
    g.go_metalinter_command = "golangci-lint"
    g.go_metalinter_enabled = {'vet', 'errcheck', 'staticcheck', 'gosimple'}
    g.go_metalinter_autosave_enabled = {'vet', 'errcheck', 'staticcheck', 'gosimple'}
    g.go_metalinter_autosave = 0
    g.go_jump_to_error = 0
    g.go_echo_go_info = 0
    g.go_auto_type_info = 1
    g.go_fmt_command = "goimports"
    g.go_fmt_autosave = 1
    g.go_guru_scope = {"..."}
    g.go_highlight_function_calls = 1
    g.go_def_mapping_enabled = 0

    autocmd('MyAutocmd', [[Filetype go nmap <buffer> gd <Plug>(go-def)]], false)
    autocmd('MyAutocmd', [[Filetype go nmap <buffer> gD <Plug>(go-describe)]], false)
    autocmd('MyAutocmd', [[Filetype go nmap <buffer> gR <Plug>(go-rename)]], false)
    autocmd('MyAutocmd', [[Filetype go nmap <buffer> gr <Plug>(go-referrers)]], false)
    autocmd('MyAutocmd', [[Filetype go nmap <buffer> <leader>gm <Plug>(go-metalinter)]], false)


    autocmd('MyAutoCmd', [[ Filetype go nmap <buffer> <f16> <Plug>(go-test) ]], false)
    autocmd('MyAutoCmd', [[ Filetype go nmap <buffer> <f17> <Plug>(go-build) ]], false)
    autocmd('MyAutoCmd', [[ Filetype go nmap <buffer> <f18> <Plug>(go-run) ]], false)
end

function M.config()
    -- TODO
end


return M
