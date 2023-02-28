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
        "lambdalisue/suda.vim",
        cmd = { "SudaRead", "SudaWrite" },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require('my_config.plugin.indent-blankline').config()
        end,
    },
    { "machakann/vim-swap" },

    { "tpope/vim-unimpaired" },
    {
        "tpope/vim-dispatch",
        cmd = { "Make", "Dispatch" },
    },
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "Gdiffsplit" },
    },
    {
        "rbong/vim-flog",
        dependencies = "tpope/vim-fugitive",
        cmd = { "Flog" },
    },
    { "rhysd/committia.vim" },
    {
        {
            "hrsh7th/cmp-nvim-lsp",
            config = function()
                require('my_config.plugin.nvim-cmp').config()
            end
        },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-vsnip" },
        {
            "hrsh7th/vim-vsnip",
            init = function()
                vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/vsnippets"
                vim.keymap.set("i", "<C-J>", function()
                    if vim.fn["vsnip#jumpable"](1) == 1 then
                        return "<Plug>(vsnip-expand-or-jump)"
                    end
                    return "<C-J>"
                end, { expr = true })

                vim.keymap.set("i", "<C-K>", function()
                    if vim.fn["vsnip#jumpable"]( -1) == 1 then
                        return "<Plug>(vsnip-jump-prev)"
                    end
                    return "<C-K>"
                end, { expr = true })
            end,
        },
        { "rafamadriz/friendly-snippets" },
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
        init = function()
            require('my_config.plugin.telescope').setup()
        end,
        config = function()
            require('my_config.plugin.telescope').config()
        end,
    },
    {
        "Raimondi/delimitMate",
        init = function()
            require('my_config.plugin.delimitMate').setup()
        end,
        event = "InsertEnter",
    },

    {
        "mbbill/undotree",
        init = function()
            require('my_config.plugin.undotree').setup()
        end,
        cmd = "UndotreeToggle",
    },
    {
        "ntpeters/vim-better-whitespace",
        init = function()
            require('my_config.plugin.vim-better-whitespace').setup()
        end,
    },
    {
        "ronakg/quickr-cscope.vim",
        init = function()
            require('my_config.plugin.quickr-cscope').setup()
        end,
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
            require('my_config.plugin.vim-illuminate').config()
        end,
    },

    {
        "mizlan/iswap.nvim",
        dependencies = "nvim-treesitter",
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
    { import = "plugins" },
})
