return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
        },
        build = "make tiktoken",          -- Only on MacOS or Linux
        opts = {},
        config = function()
            require("CopilotChat").setup {}

            local chat = require("CopilotChat")

            local km = require("my_config.utils").km_factory({})
            km({ "n", "v", "x" }, "<F10>", function()
                chat.toggle({})
            end)

            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'copilot-chat',
                callback = function(opts)
                    local bufnr = opts.buf
                    local km = require("my_config.utils").km_factory({ silent = true, buffer = bufnr })
                    km("n", "gR", "<cmd>CopilotChatReset<cr>")
                end,
            })
        end
    }
}
