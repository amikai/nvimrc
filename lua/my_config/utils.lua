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

return M
