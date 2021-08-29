local b = vim.b
local autocmd = require('my_config.utils').autocmd
local km = require('my_config.utils').km
local cmd = vim.cmd
local my_lsp = require('my_config.lsp')

-- lsp {{{
local pylsp_on_attach = function(client, bufnr)
    my_lsp.diagnostic_setting()
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    opts = {noremap = true, silent = true}
--  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--  buf_set_keymap('n', '<f9>', '<cmd>lua require("my_config.lsp").open_diagnostic_window()<CR>', opts)
    buf_set_keymap("n", '<f3>', "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--  disable diagnostic
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = false,
            virtual_text = false,
            signs = false,
            update_in_insert = false,
        }
    )

end

require('lspconfig').pylsp.setup{
    on_attach = pylsp_on_attach,
}
-- }}}

-- ale {{{
b.ale_linters = {
    python = {'flake8', 'pylint', 'pyright'}
}
km('n', ']d', '<Plug>(ale_next_error)', {noremap = false, buffer = true})
km('n', '[d', '<Plug>(go-ale_previous_error)', {noremap = false, buffer = true})

-- open location window > make it to bottom > set height > goto previous window
km('n', '<F9>', '<cmd>lopen <bar> wincmd J <bar> 5wincmd _ <bar> wincmd p<cr>', {noremap = true, buffer = true})
require('packer').loader("ale")
-- }}}

-- vim: set foldmethod=marker tw=80 sw=4 ts=4 sts =4 sta nowrap et :
