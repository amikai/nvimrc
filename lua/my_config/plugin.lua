local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "tpope/vim-dispatch",
        cmd = { "Make", "Dispatch" },
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen" },
    },
    {
        "pearofducks/ansible-vim",
        ft = { "yaml.ansible", "ansible_hosts" },
    },

    {
        "hashivim/vim-terraform",
        ft = { "hcl", "terraform" },
        init = function()
            vim.g.terraform_fmt_on_save = 1
        end,
    },
    {
        "christoomey/vim-tmux-navigator",
        cond = require("my_config.utils").is_in_tmux(),
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {}
        end
    },
    {
        "jellydn/hurl.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        ft = "hurl",
        opts = {
            -- Show debugging info
            debug = false,
            -- Show notification on run
            show_notification = false,
            -- Show response in popup or split
            mode = "split",
            -- Default formatter
            formatters = {
                json = { 'jq' }, -- Make sure you have install jq in your system, e.g: brew install jq
                html = {
                    'prettier',  -- Make sure you have install prettier in your system, e.g: npm install -g prettier
                    '--parser',
                    'html',
                },
            },
        },
    },
    {
        "vim-scripts/vis",
    },
    {
        "christianrondeau/vim-base64",
    },
    {
        "towolf/vim-helm"
    },
    { import = "plugins" },
})
