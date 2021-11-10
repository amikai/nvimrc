local M = {}

local cmd = vim.cmd
local km = require('my_config.utils').km

M.on_attach = function()
    local config = {
        -- add your config value here
        -- default value
        use_saga_diagnostic_sign = true,
        error_sign = '❌',
        warn_sign = '⚠️',
        hint_sign = '💡',
        infor_sign = 'ℹ️',
        dianostic_header_icon = '   ',
        code_action_icon = ' ',
        code_action_prompt = {
          enable = true,
          sign = true,
          sign_priority = 20,
          virtual_text = true,
        },
        -- finder_definition_icon = '  ',
        -- finder_reference_icon = '  ',
        -- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
        -- finder_action_keys = {
        --   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
        -- },
        code_action_keys = {
          quit = '<esc>',exec = '<CR>'
        },
        rename_action_keys = {
          quit = '<esc>',exec = '<CR>'  -- quit can be a table
        },
        -- definition_preview_icon = '  '
        -- "single" "double" "round" "plus"
        border_style = "round",
        rename_prompt_prefix = '➤',
        -- if you don't use nvim-lspconfig you must pass your server name and
        -- the related filetypes into this table
        -- server_filetype_map = {}
        -- like server_filetype_map = {metals = {'sbt', 'scala'}}
    }
    cmd [[
        augroup LspsagaSetting
            autocmd!
            autocmd CursorHold <buffer> lua require'lspsaga.diagnostic'.show_line_diagnostics()
        augroup END
    ]]

    require ('lspsaga').init_lsp_saga(config)

    km('n', '<leader>ca', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", {silent = true, noremap = true})
    km('v', '<leader>ca', ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", {silent = true, noremap = true})

    km('n', '<leader>k', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", {silent = true, noremap = true})
    km('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", {silent = true, noremap = true})
    km('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", {silent = true, noremap = true})

    km('n', 'gR', "<cmd>lua require('lspsaga.rename').rename()<CR>", {silent = true, noremap = true})
    km('n', '<leader>gd', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", {silent = true, noremap = true})

    km('n', ']d', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", {silent = true, noremap = true})
    km('n', '[d', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", {silent = true, noremap = true})
end

return M
