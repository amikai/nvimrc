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
        setup = function()
            vim.keymap.set(
                "n",
                "<F33>",  -- Ctrl + F9
                "<cmd>TroubleToggle<cr>",
                { silent = true }
            )
        end,
        config = function()
            require("trouble").setup({})
            vim.keymap.set(
                "n",
                "[d",
                "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<CR>",
                { silent = true }
            )
            vim.keymap.set(
                "n",
                "]d",
                "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<CR>",
                { silent = true }
            )
        end,
    })

    use({
        "bpietravalle/vim-bolt",
    })

    use({
        "lambdalisue/suda.vim",
        cmd = { "SudaRead", "SudaWrite" },
    })

    use({ "itchyny/vim-cursorword" })

    use({
        "akinsho/toggleterm.nvim",
        cmd = "ToggleTerm",
        setup = [[ require('my_config.plugin.toggleterm').setup() ]],
    })

    use({
        "lukas-reineke/indent-blankline.nvim",
        setup = function()
            vim.g.indent_blankline_disable_warning_message = true
            vim.g.indent_blankline_char = "┆"
            vim.g.indent_blankline_filetype_exclude = { "NvimTree", "diff", "tagbar", "help" }
        end,
    })

    use({ "PeterRincker/vim-searchlight" })

    use({ "machakann/vim-swap" })

    use({
        "kana/vim-operator-user",
        {
            "kana/vim-operator-replace",
            after = "vim-operator-user",
            keys = { { "", "<Plug>(operator-replace)" } },
            setup = function()
                vim.keymap.set("", "R", "<Plug>(operator-replace)", { silent = true })
            end,
        },
    })

    use({
        "andymass/vim-matchup",
        setup = [[ require('my_config.plugin.vim-matchup').setup() ]],
    })

    use({
        "tpope/vim-endwise",
        setup = function()
            vim.g.endwise_no_mappings = 1
        end,
        event = { "InsertEnter" },
    })

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
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
        setup = function()
            require("my_config.plugin.vim-go").setup()
        end,
    })

    use({
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
        setup = [[ require('my_config.plugin.telescope').setup() ]],
        cmd = "Telescope",
    })

    use({
        "mhinz/vim-sayonara",
        cmd = "Sayonara",
        setup = [[ require('my_config.plugin.vim-sayonara').setup() ]],
    })

    use({
        "Raimondi/delimitMate",
        setup = function()
            vim.g.delimitMate_expand_space = 1
            vim.g.delimitMate_smart_quotes = 1
            vim.g.delimitMate_nesting_quotes = { '"', "'" }
        end,
        event = "InsertEnter",
    })

    use({
        "mbbill/undotree",
        setup = [[ require('my_config.plugin.undotree').setup() ]],
        cmd = "UndotreeToggle",
    })

    use({
        {
            "haya14busa/vim-asterisk",
        },
        {
            "haya14busa/is.vim",
            setup = [[ require('my_config.plugin.is').setup() ]],
        },
        {
            "osyo-manga/vim-anzu",
            setup = [[ require('my_config.plugin.vim-anzu').setup() ]],
        },
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
        setup = function()
            vim.keymap.set("n", "<F2>", "<cmd>ZenMode<cr>")
        end,
        config = [[ require('my_config.plugin.zen-mode').setup() ]],
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
        event = "BufEnter",
        run = "TSUpdate",
        config = [[ require('my_config.plugin.nvim-treesitter').config() ]],
    })

    use({
        "romgrk/nvim-treesitter-context",
        after = "nvim-treesitter",
        config = function()
            require("my_config.plugin.nvim-treesitter-context").config()
        end,
    })

    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        config = function()
            require("my_config.plugin.nvim-treesitter-textobjects").config()
        end,
    })

    use({
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter",
    })

    use({
        "mizlan/iswap.nvim",
        after = "nvim-treesitter",
    })

    use({
        "junegunn/fzf",
        run = ":call fzf#install()",
    })

    use({
        "junegunn/fzf.vim",
    })

    use({
        "akinsho/bufferline.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("bufferline").setup({})
        end,
    })

    use({
        "mhartington/formatter.nvim",
        cmd = { "Format", "FormatWrite" },
        setup = function()
            local utils = require("my_config.utils")
            vim.keymap.set("n", "<F3>", function()
                local client = vim.lsp.buf_get_clients(0)
                if next(client) == nil and utils.has_plugin("formatter.nvim") then
                    vim.cmd("Format")
                else
                    vim.lsp.for_each_buffer_client(0, function(client, client_id, bufnr)
                        if client.server_capabilities.document_formatting then
                            vim.lsp.buf.format()
                        end
                    end)
                end
            end)
        end,
        config = function()
            require("my_config.plugin.formatter").setup()
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
        "preservim/tagbar",
        cmd = "TagbarToggle",
        setup = [[ require('my_config.plugin.tagbar').setup() ]],
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
