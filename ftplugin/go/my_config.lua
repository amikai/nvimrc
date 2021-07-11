
local b = vim.b
local autocmd = require('my_config.utils').autocmd
local km = require('my_config.utils').km
local cmd = vim.cmd


-- vim-go
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

km('n', 'gd', '<Plug>(go-def)', {noremap = false, buffer = true})
km('n', 'gD', '<Plug>(go-describe)', {noremap = false, buffer = true})
km('n', 'gR', '<Plug>(go-rename)', {noremap = false, buffer = true})
km('n', 'gr', '<Plug>(go-referrers)', {noremap = false, buffer = true})
km('n', '<leader>gm', '<Plug>(go-metalinter)', {noremap = false, buffer = true})
km('n', '<f3>', '<Plug>(go-fmt)', {noremap = false, buffer = true})
km('n', '<f16>', '<Plug>(go-test)', {noremap = false, buffer = true})
km('n', '<f17>', '<Plug>(go-build)', {noremap = false, buffer = true})
km('n', '<f18>', '<Plug>(go-run)', {noremap = false, buffer = true})


-- ycm
-- disable ycm diagnostic, use ale linter instead
b.ycm_show_diagnostics_ui = 0
require('packer').loader("YouCompleteMe")


-- lsp
-- require('lspconfig').gopls.setup{
--     init_options= { usePlaceholders = true },
-- }

-- ale
cmd [[nmap <buffer> ]d <Plug>(ale_next_error)]]
cmd [[nmap <buffer> [d <Plug>(ale_previous_error)]]
-- open location window > make it to bottom > set height > goto previous window
cmd [[noremap <F9> <cmd>lopen <bar> wincmd J <bar> 5wincmd _ <bar> wincmd p<cr>]]
require('packer').loader("ale")
