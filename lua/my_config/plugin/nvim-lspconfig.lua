-- Copy from https://github.com/jdhao/nvim-config/blob/master/lua/config/lsp.lua
local M = {}

local keymap = vim.keymap
local fn = vim.fn
local utils = require("my_config.utils")

-- diagnostic setting {{{
M.toggle_diagnostic_window = function()
    local winnr = vim.fn.winnr()
    local locwin_open = vim.fn.getloclist(0, { winid = 0 }).winid ~= 0
    if locwin_open then
        vim.cmd("lclose")
    else
        vim.diagnostic.setloclist({ open = true })
        vim.cmd("wincmd J")
        vim.cmd("5wincmd _")
    end
    vim.cmd(string.format("%swincmd w", winnr))
end

-- Change diagnostic signs.
fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- global config for diagnostic
vim.diagnostic.config {
    underline = false,
    virtual_text = false,
    signs = true,
    severity_sort = true,
}
-- }}}

-- lsp attach function {{{
local custom_attach = function(client, bufnr)
    local map = function(mode, l, r, opts)
        opts = opts or {}
        opts.silent = true
        opts.buffer = bufnr
        keymap.set(mode, l, r, opts)
    end

    map("n", "gd", vim.lsp.buf.definition)
    map("n", "<F9>", M.toggle_diagnostic_window)
    if utils.has_plugin("lspsaga.nvim") then
        map("n", "K", "<cmd>Lspsaga hover_doc<cr>")
        map("n", "gp", "<cmd>Lspsaga peek_definition<cr>")
        map("n", "gR", "<cmd>Lspsaga rename<cr>")
        map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>")
        map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
    else
        map("n", "K", vim.lsp.buf.hover)
        -- map("n", "<C-k>", vim.lsp.buf.signature_help)
        map("n", "gR", vim.lsp.buf.rename)
        map("n", "gr", vim.lsp.buf.references)
        map("n", "[d", vim.diagnostic.goto_prev)
        map("n", "]d", vim.diagnostic.goto_next)
        map("n", "gi", vim.lsp.buf.implementation)
        map("n", "gD", vim.lsp.buf.declaration)

        map("n", "<leader>ca", vim.lsp.buf.code_action)
        map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
        map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
        map("n", "<leader>wl", function()
            vim.pretty_print(vim.lsp.buf.list_workspace_folders())
        end)
    end

    map("n", "<F3>", vim.lsp.buf.format)
    if client.server_capabilities.document_range_formatting then
        map("x", "<F3>", vim.lsp.buf.range_formatting)
    end

    -- The blow command will highlight the current variable and its usages in the buffer.
    if client.server_capabilities.document_highlight then
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
end
-- }}}

local lspconfig = require("lspconfig")

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- html lsp setting {{{
lspconfig.html.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
})
-- }}}

-- terraform lsp setting {{{
lspconfig.jsonnet_ls.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
})
-- }}}

-- terraform lsp setting {{{
lspconfig.terraformls.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
})
-- }}}

-- dockerfile lsp setting {{{
lspconfig.dockerls.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
})
--}}}

-- ansible lsp setting {{{
lspconfig.ansiblels.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
})
-- }}}

-- yaml lsp setting {{{
lspconfig.yamlls.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = {
                ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.yaml",
            },
        },
    },
})
-- }}}

-- lua lsp setting {{{
lspconfig.sumneko_lua.setup({
    on_attach = custom_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                library = {
                    fn.stdpath("config"),
                },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    capabilities = capabilities,
})
-- }}}

-- bash lsp setting {{{
lspconfig.bashls.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
})
-- }}}

-- vimscript lsp setting {{{
lspconfig.vimls.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
})
-- }}}

-- python pylsp setting {{{
lspconfig.pylsp.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
})
-- }}}

-- golang lsp setting {{{
-- see https://github.com/golang/tools/blob/master/gopls/doc/settings.md
lspconfig.gopls.setup({
    cmd = { "gopls", "serve" },
    on_attach = custom_attach,
    capabilities = capabilities,
    init_options = {
        usePlaceholders = true,
    },
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        },
    },
})

-- }}}

return M

-- vim: set foldmethod=marker tw=80 sw=4 ts=4 sts =4 sta nowrap et :
