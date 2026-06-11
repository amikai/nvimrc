-- Small helpers around the built-in plugin manager (:h vim.pack).
local M = {}

function M.gh(repo)
    return "https://github.com/" .. repo
end

-- Install plugins and load them (during startup they are sourced in the
-- normal plugin loading phase, like `:packadd!`).
function M.add(specs)
    vim.pack.add(specs, { confirm = false })
end

-- Install plugins but do NOT load them. Load later with M.load() from an
-- autocommand or keymap.
function M.register(specs)
    vim.pack.add(specs, { confirm = false, load = function() end })
end

function M.load(names)
    for _, name in ipairs(names) do
        vim.cmd.packadd(name)
    end
end

return M
