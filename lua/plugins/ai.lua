return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "fzbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
        },
        build = "make tiktoken",          -- Only on MacOS or Linux
        opts = {},
        config = function()
            require('copilot').setup({})
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
                    km("n", "gR", "<cmd>CopilotChatReset<cr>")
                end,
            })
        end
    }
}
