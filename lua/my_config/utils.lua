local M = {}

function M.km(modes, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = true
    vim.keymap.set(modes, lhs, rhs, opts)
end

function M.is_load(plugin)
    return packer_plugins ~= nil and packer_plugins[plugin] ~= nil and packer_plugins[plugin].loaded ~= nil
end

function M.has_plugin(plugin)
    return packer_plugins ~= nil and packer_plugins[plugin] ~= nil
end

-- See https://unix.stackexchange.com/questions/10689/how-can-i-tell-if-im-in-a-tmux-session-from-a-bash-script
function M.is_in_tmux()
    return os.getenv("TERM_PROGRAM") == "tmux"
end

function M.executable(name)
    if fn.executable(name) > 0 then
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
        "<F8> tagbar",
        "<F9> diagnostics",
        "<F12> show msg"
    }
    print(table.concat(msgs, " | "))
end

return M
