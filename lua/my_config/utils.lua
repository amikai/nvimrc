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

M.show_function_keymapping = function()
    local msgs = {
        "<F1> term",
        "<F2> focus",
        "<F3> codefmt",
        "<F4> file",
        "<F6> undotree",
        "<F8> symbol",
        "<F10> chat",
        "<F12> show msg",
    }
    print(table.concat(msgs, " | "))
end

M.show_alt_function_keymapping = function()
    local msgs = {
        "<A-F2> focus",
    }
    print(table.concat(msgs, " | "))
end

M.in_git_repo = function()
    return vim.fn.system("git rev-parse --is-inside-work-tree") == "true\n"
end

M.get_venv_path = function()
    local venv_path = vim.fn.getcwd() .. "/.venv"
    if vim.fn.isdirectory(venv_path) == 1 then
        return venv_path
    end
    return nil
end


M.get_py_path = function()
    if vim.fn.executable('uv') == 1 then
        return vim.trim(vim.fn.system('uv python find'))
    end



    local venv_path = M.get_venv_path()
    if venv_path == nil then
        return vim.fn.exepath("python3") or vim.fn.exepath("python")
    end

    local pypath = venv_path .. "/bin/python"
    if vim.fn.executable(pypath) == 1 then
        return pypath
    end
end

return M
