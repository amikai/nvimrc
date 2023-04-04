local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
        "thinca/vim-qfreplace",
        cmd = { "Qfreplace" },
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen" },
    },
    {
        "RRethy/vim-illuminate",
        dependencies = "nvim-treesitter",
        config = function()
            require("my_config.plugin.vim-illuminate").config()
        end,
    },
    {
        "chr4/nginx.vim",
        ft = "nginx",
    },

    {
        "pearofducks/ansible-vim",
        ft = { "yaml.ansible", "ansible_hosts" },
    },

    {
        "hashivim/vim-terraform",
        ft = { "hcl", "terraform" },
        setup = function()
            vim.g.terraform_fmt_on_save = 1
        end,
    },

    {
        "christoomey/vim-tmux-navigator",
        cond = require("my_config.utils").is_in_tmux(),
    },
    {
        "tpope/vim-unimpaired",
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {}
        end
    },
    { import = "plugins" },
})
