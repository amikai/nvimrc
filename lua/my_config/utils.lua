local M = {}

function M.km(modes, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = true
    vim.keymap.set(modes, lhs, rhs, opts)
end

function M.km_factory(opts)
    return function(modes, lhs, rhs)
        vim.keymap.set(modes, lhs, rhs, opts)
    end
end

-- See https://unix.stackexchange.com/questions/10689/how-can-i-tell-if-im-in-a-tmux-session-from-a-bash-script
function M.is_in_tmux()
    return os.getenv("TERM_PROGRAM") == "tmux"
end

function M.executable(name)
    if vim.fn.executable(name) > 0 then
        return true
    end

    return false
end

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

M.show_function_keymapping = function()
    msgs = {
        "<F1> term",
        "<F2> focus",
        "<F3> codefmt",
        "<F4> file",
        "<F5> whitespace",
        "<F6> undotree",
        "<F8> vista",
        "<F9> diagnostics",
        "<F12> show msg",
    }
    print(table.concat(msgs, " | "))
end

M.show_alt_function_keymapping = function()
    msgs = {
        "<A-F2> focus",
    }
    print(table.concat(msgs, " | "))
end

M.in_git_repo = function()
    return vim.fn.system("git rev-parse --is-inside-work-tree") == "true\n"
end

M.common_lsp_attach = function(client, bufnr)
    local autocmd = vim.api.nvim_create_autocmd
    local km = require("my_config.utils").km_factory({ silent = true, buffer = bufnr })

    -- See https://github.com/redhat-developer/yaml-language-server/issues/486
    if client.name == "yamlls" then
        client.server_capabilities.documentFormattingProvider = true
    end

    km("n", "gd", vim.lsp.buf.definition)
    km("n", "K", vim.lsp.buf.hover)
    -- km("n", "<C-k>", vim.lsp.buf.signature_help)
    km("n", "gR", vim.lsp.buf.rename)
    km("n", "gr", vim.lsp.buf.references)
    km("n", "[d", vim.diagnostic.goto_prev)
    km("n", "]d", vim.diagnostic.goto_next)
    km("n", "gi", vim.lsp.buf.implementation)
    km("n", "gD", vim.lsp.buf.declaration)

    km("n", "<leader>ca", vim.lsp.buf.code_action)
    km("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
    km("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
    km("n", "<leader>wl", function()
        vim.pretty_print(vim.lsp.buf.list_workspace_folders())
    end)

    if client.server_capabilities.documentFormattingProvider then
        km("n", "<F3>", vim.lsp.buf.format)
    end

    if client.server_capabilities.documentRangeFormattingProvider then
        -- FIXME
        -- km("x", "<F3>", vim.lsp.buf.range_formatting)
    end

    local msg = string.format("Language server %s started!", client.name)
    vim.api.nvim_echo({ { msg, "MoreMsg" } }, false, {})
end

return M
