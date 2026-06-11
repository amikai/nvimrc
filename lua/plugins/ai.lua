local pack = require("my_config.pack")
local km = require("my_config.utils").km_factory({})

-- Build hook (:h vim.pack-events)
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "CopilotChat.nvim" and (kind == "install" or kind == "update") then
            vim.system({ "make", "tiktoken" }, { cwd = ev.data.path }):wait()
        end
    end,
})

-- CopilotChat is loaded on demand on first <F10>.
pack.register({ pack.gh("CopilotC-Nvim/CopilotChat.nvim") })

local done = false
local ensure = function()
    if done then
        return
    end
    done = true
    require("plugins.copilot").ensure()
    pack.load({ "CopilotChat.nvim" })
    require("CopilotChat").setup({})
end

km({ "n", "v", "x" }, "<F10>", function()
    ensure()
    require("CopilotChat").toggle({})
end)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "copilot-chat",
    callback = function()
        km("n", "gR", "<cmd>CopilotChatReset<cr>")
    end,
})
