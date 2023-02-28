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
        "arcticicestudio/nord-vim",
        config = function()
            -- vim.cmd[[colorscheme nord]]
        end,
    },
    {
        "cocopon/iceberg.vim",
        config = function()
            vim.cmd [[colorscheme iceberg]]
        end,
    },
    {
        "Mofiqul/vscode.nvim",
        init = function()
            vim.g.vscode_style = "dark"
        end,
        config = function()
            -- vim.cmd([[colorscheme vscode]])
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        cmd = { "Trouble", "TroubleClose", "TroubleToggle" },
        init = function()
            require('my_config.plugin.trouble').setup()
        end,
        config = function()
            require('my_config.plugin.trouble').config()
        end,
    },
    {
        "lambdalisue/suda.vim",
        cmd = { "SudaRead", "SudaWrite" },
    },
    {
        "akinsho/toggleterm.nvim",
        cmd = 'ToggleTerm',
        init = function()
            require('my_config.plugin.toggleterm').setup()
        end,
        config = function()
            require("toggleterm").setup()
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require('my_config.plugin.indent-blankline').config()
        end,
    },
    { "machakann/vim-swap" },
    {
        "gbprod/substitute.nvim",
        keys = {
            { "n", "R" },
            { "x", "R" },
            { "n", "RR" },
            { "n", "cx" },
        },
        config = function()
            require("substitute").setup({})
            vim.keymap.set("n", "R", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
            vim.keymap.set("x", "R", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
            vim.keymap.set("n", "RR", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
            vim.keymap.set("n", "cx", "<cmd>lua require('substitute.exchange').operator()<cr>", { noremap = true })
        end
    },
    {
        "andymass/vim-matchup",
        init = function()
            require('my_config.plugin.vim-matchup').setup()
        end,
    },
    {
        'numToStr/Comment.nvim',
        keys = {
            { "n", "gc" },
            { "x", "gc" },
            { "n", "gcc" },
        },
        config = function()
            require('Comment').setup()
        end,
    },

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
        "simrat39/rust-tools.nvim",
        config = [[ require("my_config.plugin.rust-tools").config() ]]
    },

    {
        "rust-lang/rust.vim",
        ft = "rust",
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
        "mhinz/vim-sayonara",
        cmd = "Sayonara",
        init = function()
            require('my_config.plugin.vim-sayonara').setup()
        end
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
        {
            "kevinhwang91/nvim-hlslens",
            dependencies = "vim-asterisk",
            branch = "main",
            keys = {
                { "n", "*" }, { "x", "*" },
                { "n", "#" }, { "x", "#" },
                { "n", "g*" }, { "x", "g*" },
                { "n", "#" }, { "x", "g#" },
                { "n", "n" }, { "n", "N" }
            },
            config = function()
                require('my_config.plugin.hlslens').config()
            end,

        },
        {
            "haya14busa/vim-asterisk",
        }
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
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        init = function()
            require('my_config.plugin.zen-mode').setup()
        end,
        config = function()
            require('my_config.plugin.zen-mode').config()
        end,
    },

    {
        "folke/twilight.nvim",
        cmd = "Twilight",
        dependencies = "nvim-treesitter",
        init = function()
            require('my_config.plugin.twilight').setup()
        end,
        config = function()
            require('my_config.plugin.twilight').config()
        end,
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
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require('my_config.plugin.nvim-treesitter').config()
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = "nvim-treesitter",
        config = function()
            require("my_config.plugin.nvim-treesitter-context").config()
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter",
    },

    {
        "p00f/nvim-ts-rainbow",
        dependencies = "nvim-treesitter",
    },

    {
        "RRethy/nvim-treesitter-endwise",
        dependencies = "nvim-treesitter",
        event = "InsertEnter",
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
        "akinsho/bufferline.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({})
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                extensions = {
                    "nvim-tree",
                    "quickfix",
                    "toggleterm",
                    "fugitive",
                },
            })
        end,
    },
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {
            'kyazdani42/nvim-web-devicons',
        },
        init = function()
            vim.api.nvim_set_keymap(
                "n",
                "<F4>",
                "<cmd>NvimTreeToggle<cr>",
                { silent = true }
            )
        end,
        config = function()
            require("nvim-tree").setup({
                git = {
                    enable = false,
                },
            })
        end,
        cmd = 'NvimTreeToggle',
        tag = 'nightly'
    },

    {
        "t9md/vim-choosewin",
        init = function()
            require('my_config.plugin.vim-choosewin').setup()
        end,
        keys = { { "n", "<Plug>(choosewin)" } },
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
