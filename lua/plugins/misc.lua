local pack = require("my_config.pack")
local gh = pack.gh

vim.g.terraform_fmt_on_save = 1

pack.add({
    gh("tpope/vim-dispatch"),
    gh("kevinhwang91/nvim-bqf"),
    gh("sindrets/diffview.nvim"),
    gh("pearofducks/ansible-vim"),
    gh("hashivim/vim-terraform"),
    gh("folke/todo-comments.nvim"),
    gh("jellydn/hurl.nvim"),
    gh("vim-scripts/vis"),
    gh("christianrondeau/vim-base64"),
    gh("towolf/vim-helm"),
})

if require("my_config.utils").is_in_tmux() then
    pack.add({ gh("christoomey/vim-tmux-navigator") })
end

require("todo-comments").setup({})

require("hurl").setup({
    -- Show debugging info
    debug = false,
    -- Show notification on run
    show_notification = false,
    -- Show response in popup or split
    mode = "split",
    -- Default formatter
    formatters = {
        json = { "jq" }, -- Make sure you have install jq in your system, e.g: brew install jq
        html = {
            "prettier", -- Make sure you have install prettier in your system, e.g: npm install -g prettier
            "--parser",
            "html",
        },
    },
})
