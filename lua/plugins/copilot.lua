local pack = require("my_config.pack")

pack.register({ pack.gh("zbirenbaum/copilot.lua") })

local M = {}

local done = false

-- Load and set up copilot.lua once. Called on InsertEnter and by modules
-- that need copilot earlier (CopilotChat).
function M.ensure()
    if done then
        return
    end
    done = true
    pack.load({ "copilot.lua" })
    require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
            markdown = true,
            help = true,
        },
    })
end

vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("my_config_copilot", { clear = true }),
    once = true,
    callback = M.ensure,
})

return M
