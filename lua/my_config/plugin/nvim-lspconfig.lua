-- Copy from https://github.com/jdhao/nvim-config/blob/master/lua/config/lsp.lua
local M = {}

-- diagnostic setting {{{
function M.show_line_diagnostics()
    local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    }
    vim.lsp.diagnostic.show_line_diagnostics(opts)
end


M.toggle_diagnostic_window = function()
    local winnr = vim.fn.winnr()
    local locwin_open = vim.fn.getloclist(0, {winid = 0}).winid ~= 0
    if locwin_open then
        vim.cmd("lclose")
    else
        vim.lsp.diagnostic.set_loclist({ open_loclist = true })
        vim.cmd("wincmd J")
        vim.cmd("5wincmd _")
    end
    vim.cmd(string.format("%swincmd w", winnr))

end

vim.fn.sign_define("LspDiagnosticsSignError", { text = "❌", texthl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "⚠️", texthl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "ℹ️", texthl = "LspDiagnosticsDefaultInformation" })
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "💡", texthl = "LspDiagnosticsDefaultHint" })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
})

-- Refs: https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#show-source-in-diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, _, params, client_id, _)
    local uri = params.uri
    local bufnr = vim.uri_to_bufnr(uri)

    if not bufnr then
        return
    end

    if not vim.api.nvim_buf_is_loaded(bufnr) then
        return
    end

    local diagnostics = params.diagnostics
    for i, v in ipairs(diagnostics) do
        diagnostics[i].message = string.format("%s: %s", v.source, v.message)
    end
    vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

    local config = {
        underline = false,
        virtual_text = false,
        signs = { priority = 10 },
        update_in_insert = false,
    }
    vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
end

-- The following settings works with the bleeding edge neovim.
-- See https://github.com/neovim/neovim/pull/13998.
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})
-- }}}
--
-- lsp attach function {{{
local custom_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { noremap = true, silent = true }
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "<C-]>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    -- buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<F9>", "<cmd>lua require('my_config.plugin.nvim-lspconfig').toggle_diagnostic_window()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    vim.cmd([[
        autocmd CursorHold <buffer> lua require('my_config.plugin.nvim-lspconfig').show_line_diagnostics()
    ]])

    -- Set some key bindings conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<F3>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("x", "<F3>", "<cmd>lua vim.lsp.buf.range_formatting()<CR><ESC>", opts)
    end

    -- The blow command will highlight the current variable and its usages in the buffer.
    if client.resolved_capabilities.document_highlight then
        vim.cmd([[
            hi link LspReferenceRead Visual
            hi link LspReferenceText Visual
            hi link LspReferenceWrite Visual
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]])
    end

    local msg = string.format("Language server %s started!", client.name)
    vim.api.nvim_echo({ { msg, "MoreMsg" } }, false, {})
    -- vim.notify(msg, 'info', {title = 'Nvim-config', timeout = 2500})
end
-- }}}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")

-- lua lsp setting {{{
local sumneko_binary_path = vim.fn.exepath("lua-language-server")
local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ":h:h:h")

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.sumneko_lua.setup({
    on_attach = custom_attach,
    cmd = { sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua" },
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})
-- }}}

-- bsh lsp setting {{{
lspconfig.bashls.setup({
    on_attach = custom_attach
})
-- }}}

-- vimscript lsp setting {{{
lspconfig.vimls.setup({
    on_attach = custom_attach
})
-- }}}


-- golang lsp setting {{{
lspconfig.gopls.setup({
    on_attach = function(client, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        vim.cmd([[
            autocmd cursorhold <buffer> lua require('my_config.plugin.nvim-lspconfig').show_line_diagnostics()
        ]])

        local opts = { noremap = true, silent = true }
        buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
        buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
        buf_set_keymap("n", "<F9>", "<cmd>lua require('my_config.plugin.nvim-lspconfig').toggle_diagnostic_window()<CR>", opts)

        local msg = string.format("Language server %s started!", client.name)
        vim.api.nvim_echo({ { msg, "MoreMsg" } }, false, {})
    end
})

-- }}}

return M

-- vim: set foldmethod=marker tw=80 sw=4 ts=4 sts =4 sta nowrap et :
