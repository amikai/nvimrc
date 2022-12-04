local packer_install_dir = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local packer_repo = "https://github.com/wbthomason/packer.nvim"
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir)

if vim.fn.empty(vim.fn.glob(packer_install_dir)) > 0 then
    vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
    vim.cmd(install_cmd)
    vim.cmd([[ packadd packer.nvim ]])
end

vim.cmd([[packadd packer.nvim]])
vim.cmd([[packadd vimball]])

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use({
        "sainnhe/gruvbox-material",
        setup = function()
            vim.g.gruvbox_material_background = "soft"
        end,
        config = function()
            -- vim.cmd[[colorscheme gruvbox-material]]
        end,
    })

    use({
        "arcticicestudio/nord-vim",
        config = function()
            -- vim.cmd[[colorscheme nord]]
        end,
    })

    use({
        "cocopon/iceberg.vim",
        config = function()
            -- vim.cmd[[colorscheme iceberg]]
        end,
    })

    use({
        "Mofiqul/vscode.nvim",
        setup = function()
            vim.g.vscode_style = "dark"
        end,
        config = function()
            vim.cmd([[colorscheme vscode]])
        end,
    })

    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        cmd = { "Trouble", "TroubleClose", "TroubleToggle" },
        setup = [[ require('my_config.plugin.trouble').setup() ]],
        config = [[ require('my_config.plugin.trouble').config() ]],
    })

    use({
        "lambdalisue/suda.vim",
        cmd = { "SudaRead", "SudaWrite" },
    })

    use({
        "akinsho/toggleterm.nvim",
        cmd = 'ToggleTerm',
        setup = [[ require('my_config.plugin.toggleterm').setup() ]],
        config = [[ require("toggleterm").setup() ]],
    })

    use({
        "lukas-reineke/indent-blankline.nvim",
        config = [[ require('my_config.plugin.indent-blankline').config() ]],
    })

    use({ "machakann/vim-swap" })

    use({
        "gbprod/substitute.nvim",
        keys = {
            {"n", "R"},
            {"x", "R"},
            {"n", "RR"},
            {"n", "cx"},
        },
        config = function()
            require("substitute").setup({})
            vim.keymap.set("n", "R", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
            vim.keymap.set("x", "R", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
            vim.keymap.set("n", "RR", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
            vim.keymap.set("n", "cx", "<cmd>lua require('substitute.exchange').operator()<cr>", { noremap = true })
        end
    })

    use({
        "andymass/vim-matchup",
        setup = [[ require('my_config.plugin.vim-matchup').setup() ]],
    })

    use {
        'numToStr/Comment.nvim',
        keys = {
            {"n", "gc"},
            {"x", "gc"},
            {"n", "gcc"},
        },
        config = [[ require('Comment').setup() ]]
    }

    use({ "tpope/vim-unimpaired" })

    use({
        "tpope/vim-dispatch",
        cmd = { "Make", "Dispatch" },
    })

    use({
        "tpope/vim-fugitive",
        cmd = { "Git", "Gdiffsplit" },
    })

    use({
        "rbong/vim-flog",
        cmd = { "Flog" },
    })

    use({ "rhysd/committia.vim" })

    use({
        "neovim/nvim-lspconfig",
        config = [[ require('my_config.plugin.nvim-lspconfig') ]],
    })

    use({
        "williamboman/mason.nvim",
        config = function()
            require('my_config.plugin.mason').config({
                ensure_installed = {
                    "buf",
                    "black",
                },
            })
        end,
    })

    use({
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "ansiblels",
                    "gopls",
                    "pyright",
                    "rust_analyzer",
                    "golangci_lint_ls",
                    "dockerls",
                    "jsonnet_ls",
                    "terraformls",
                    "html",
                    "bashls",
                    "sumneko_lua",
                    "vimls",
                    "yamlls",
                },
                automatic_installation = true,
            })
        end,
    })

    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = [[ require("my_config.plugin.null-ls").config() ]]
    })

    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            local saga = require("lspsaga")

            saga.init_lsp_saga({
                -- your configuration
                code_action_lightbulb = {
                    enable = false
                }
            })
        end,
    })

    use({
        {
            "hrsh7th/cmp-nvim-lsp",
            config = [[ require('my_config.plugin.nvim-cmp').config() ]],
        },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-vsnip" },
        {
            "hrsh7th/vim-vsnip",
            setup = function()
                vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/vsnippets"
                vim.keymap.set("i", "<C-J>", function()
                    if vim.fn["vsnip#jumpable"](1) == 1 then
                        return "<Plug>(vsnip-expand-or-jump)"
                    end
                    return "<C-J>"
                end, { expr = true })

                vim.keymap.set("i", "<C-K>", function()
                    if vim.fn["vsnip#jumpable"](-1) == 1 then
                        return "<Plug>(vsnip-jump-prev)"
                    end
                    return "<C-K>"
                end, { expr = true })
            end,
        },
        { "rafamadriz/friendly-snippets" },
    })

    use({
        "fatih/vim-go",
        run = ":GoUpdateBinaries",
        ft = "go",
        setup = [[ require("my_config.plugin.vim-go").setup() ]]
    })

    use({
        "simrat39/rust-tools.nvim",
        config = [[ require("my_config.plugin.rust-tools").config() ]]
    })

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    use({
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
        setup = [[ require('my_config.plugin.telescope').setup() ]],
        config = [[ require('my_config.plugin.telescope').config() ]],
    })

    use({
        "mhinz/vim-sayonara",
        cmd = "Sayonara",
        setup = [[ require('my_config.plugin.vim-sayonara').setup() ]],
    })

    use({
        "Raimondi/delimitMate",
        setup = [[ require('my_config.plugin.delimitMate').setup() ]],
        event = "InsertEnter",
    })

    use({
        "mbbill/undotree",
        setup = [[ require('my_config.plugin.undotree').setup() ]],
        cmd = "UndotreeToggle",
    })

    use({
        {
            "kevinhwang91/nvim-hlslens",
            branch = "main",
            keys = {
                { "n", "*" }, { "x", "*" },
                { "n", "#" }, { "x", "#" },
                { "n", "g*" }, { "x", "g*" },
                { "n", "#" }, { "x", "g#" },
                { "n", "n" }, { "n", "N" }
            },
            config = [[ require('my_config.plugin.hlslens').config() ]],

        },
        {
            "haya14busa/vim-asterisk",
            opt = true,
        }
    })

    use({
        "ntpeters/vim-better-whitespace",
        setup = [[ require('my_config.plugin.vim-better-whitespace').setup() ]],
    })

    use({
        "ronakg/quickr-cscope.vim",
        setup = [[ require('my_config.plugin.quickr-cscope').setup() ]],
    })

    use({
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    })

    use({
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        setup = [[ require('my_config.plugin.zen-mode').setup() ]],
        config = [[ require('my_config.plugin.zen-mode').config() ]],
    })

    use({
        "folke/twilight.nvim",
        cmd = "Twilight",
        after = "nvim-treesitter",
        setup = [[ require('my_config.plugin.twilight').setup() ]],
        config = [[ require('my_config.plugin.twilight').config() ]],
    })

    use({
        "thinca/vim-qfreplace",
        cmd = { "Qfreplace" },
    })

    use({
        "lewis6991/gitsigns.nvim",
        config = [[ require('my_config.plugin.gitsigns').config() ]],
    })

    use({
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen" },
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = "TSUpdate",
        config = [[ require('my_config.plugin.nvim-treesitter').config() ]],
    })

    use({
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
        config = function()
            require("my_config.plugin.nvim-treesitter-context").config()
        end,
    })

    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    })

    use({
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter",
    })

    use({
        "RRethy/nvim-treesitter-endwise",
        after = "nvim-treesitter",
        event = "InsertEnter",
    })

    use({
        "RRethy/vim-illuminate",
        after = "nvim-treesitter",
        config = [[ require('my_config.plugin.vim-illuminate').config() ]],
    })

    use({
        "mizlan/iswap.nvim",
        after = "nvim-treesitter",
    })

    use({
        "akinsho/bufferline.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("bufferline").setup({})
        end,
    })

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
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
    })

    use({
        "liuchengxu/vista.vim",
        cmd = "Vista",
        setup = function()
            vim.api.nvim_set_keymap(
                "n",
                "<F8>",
                "<cmd>Vista!!<cr>",
                { silent = true }
            )
        end
    })

    use({
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
        setup = function()
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
    })

    use({
        "t9md/vim-choosewin",
        setup = [[ require('my_config.plugin.vim-choosewin').setup() ]],
        keys = { { "n", "<Plug>(choosewin)" } },
    })

    use({
        "chr4/nginx.vim",
        ft = "nginx",
    })

    use({
        "pearofducks/ansible-vim",
        ft = { "yaml.ansible", "ansible_hosts" },
    })

    use({
        "google/vim-jsonnet",
        ft = { "jsonnet" },
    })

    use({
        "Glench/Vim-Jinja2-Syntax",
        ft = "jinja",
    })

    use({
        "hashivim/vim-terraform",
        ft = { "hcl", "terraform" },
        setup = function()
            vim.g.terraform_fmt_on_save = 1
        end,
    })

    use({
        "christoomey/vim-tmux-navigator",
        cond = [[ require("my_config.utils").is_in_tmux() ]],
    })
end)
