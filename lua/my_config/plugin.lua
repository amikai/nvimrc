local packer_install_dir = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local packer_repo =  "https://github.com/wbthomason/packer.nvim"
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir)

if vim.fn.empty(vim.fn.glob(packer_install_dir)) > 0 then
    vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
    vim.cmd(install_cmd)
    vim.cmd [[ packadd packer.nvim ]]
end

vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd vimball]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'sainnhe/gruvbox-material',
        setup = function()
            vim.g.gruvbox_material_background = 'soft'
        end,
        config = function()
            -- vim.cmd[[colorscheme gruvbox-material]]
        end
    }

    use {
        'arcticicestudio/nord-vim',
        config = function()
            -- vim.cmd[[colorscheme nord]]
        end
    }

    use {
        'cocopon/iceberg.vim',
        config = function()
            vim.cmd[[colorscheme iceberg]]
        end
    }

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
            vim.api.nvim_set_keymap("n", "[d", "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<CR>", {silent = true, noremap = true})
            vim.api.nvim_set_keymap("n", "]d", "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<CR>", {silent = true, noremap = true})
        end
    }

    use {
        'bpietravalle/vim-bolt'
    }

    use {
         'luochen1990/rainbow',
        setup = function()
            vim.g.rainbow_active = 1
        end,
    }

    use {
        'lambdalisue/suda.vim',
        cmd = {'SudaRead', 'SudaWrite'}
    }

    use { 'itchyny/vim-cursorword'}

    use {
        'akinsho/toggleterm.nvim',
        setup = [[ require('my_config.plugin.toggleterm').setup() ]]
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        setup = function()
            vim.g.indent_blankline_disable_warning_message = true
            vim.g.indent_blankline_filetype_exclude = {'fern', 'diff', 'tagbar', 'help'}
        end
    }

    use {'PeterRincker/vim-searchlight'}

    use { 'machakann/vim-swap' }

    use {
        'glts/vim-textobj-comment',
        requires = {'kana/vim-textobj-user'},
    }

    use {
        'sgur/vim-textobj-parameter',
        requires = {'kana/vim-textobj-user'},
    }

    use {
        'kana/vim-operator-user',
        requires = {'kana/vim-operator-replace'},
        config = function()
            vim.api.nvim_set_keymap('', 'R', '<Plug>(operator-replace)', {})
        end
    }

    use {
        'andymass/vim-matchup',
        setup = [[ require('my_config.plugin.vim-matchup').setup() ]]
    }

    use {
        'tpope/vim-endwise',
        setup = function()
            vim.g.endwise_no_mappings = 1
        end,
        event = {'InsertEnter'}
    }

    use { 'tpope/vim-commentary' }

    use { 'tpope/vim-unimpaired' }

    use {
        'tpope/vim-dispatch'
    }

    use {
      'tpope/vim-fugitive',
      cmd = {'Git', 'Gdiffsplit'}
    }

    use { "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } }

    use {'rhysd/committia.vim'}

    use {
        'neovim/nvim-lspconfig',
        config = [[ require('my_config.plugin.nvim-lspconfig') ]]
    }

    use {
        {
            'hrsh7th/cmp-nvim-lsp',
            config = [[ require('my_config.plugin.nvim-cmp').config() ]]
        },
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-vsnip'},
        {
            'hrsh7th/vim-vsnip',
            setup = function()
                vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/vsnippets'
            end
        },
        {'rafamadriz/friendly-snippets'}
    }

    use {
        'numirias/semshi',
        run = ':UpdateRemotePlugins'
    }

    use {
        'fatih/vim-go',
        run = ':GoUpdateBinaries',
        ft = 'go',
        setup = [[ require('my_config.plugin.vim-go').setup() ]]
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        setup = [[ require('my_config.plugin.telescope').setup() ]],
        cmd = 'Telescope'
    }

    use {
        'mhinz/vim-sayonara',
        cmd = 'Sayonara',
        setup = [[ require('my_config.plugin.vim-sayonara').setup() ]]
    }

    use {
        'Raimondi/delimitMate',
        setup = function()
            vim.g.delimitMate_expand_space = 1
            vim.g.delimitMate_smart_quotes = 1
            vim.g.delimitMate_nesting_quotes = {'"', "'"}
        end,
        event = 'InsertEnter'
    }

    use {
        'mbbill/undotree',
        setup = [[ require('my_config.plugin.undotree').setup() ]],
        cmd = 'UndotreeToggle'
    }

    use {
        {'haya14busa/vim-asterisk'},
        {
            'haya14busa/is.vim',
            setup = [[ require('my_config.plugin.is').setup() ]]
        },
        {
            'osyo-manga/vim-anzu',
            setup = [[ require('my_config.plugin.vim-anzu').setup() ]]
        }
    }

    use {
        'ntpeters/vim-better-whitespace',
        setup = [[ require('my_config.plugin.vim-better-whitespace').setup() ]]
    }

    use {
        'ronakg/quickr-cscope.vim',
        setup = [[ require('my_config.plugin.quickr-cscope').setup() ]]
    }

    use {
        'kevinhwang91/nvim-bqf'
    }

    use {
        'junegunn/goyo.vim',
        setup = [[ require('my_config.plugin.goyo').setup() ]]

    }

    use {
        'thinca/vim-qfreplace',
        cmd = {'Qfreplace'}
    }

    use {
        'mhinz/vim-signify',
        setup = [[ require('my_config.plugin.vim-signify').setup() ]]
    }

    use {
        'sindrets/diffview.nvim',
        cmd = {'DiffviewOpen'}
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = 'TSUpdate',
        config = [[ require('my_config.plugin.nvim-treesitter').config() ]]
    }

    use {
        'romgrk/nvim-treesitter-context',
        requires = {'nvim-treesitter/nvim-treesitter'},
        config = function()
            require('my_config.plugin.nvim-treesitter-context').config()
        end
    }

    use {
        'vim-airline/vim-airline',
        setup = [[ require('my_config.plugin.vim-airline').setup() ]]
    }

    use {
        'preservim/tagbar',
        setup = [[ require('my_config.plugin.tagbar').setup() ]]
    }

    use {
        'lambdalisue/fern.vim',
        setup = function()
            vim.fn['my_config#fern#setting']()
            vim.cmd [[autocmd FileType fern call my_config#fern#keymapping()]]
        end
    }

    use {
        'lambdalisue/fern-git-status.vim',
    }

    use {
        't9md/vim-choosewin',
        setup = [[ require('my_config.plugin.vim-choosewin').setup() ]]
    }

    use {
        'chr4/nginx.vim',
        ft = 'nginx'
    }

    use {
        'pearofducks/ansible-vim',
        ft = {'yaml.ansible', 'ansible_hosts'}
    }

    use {
        'google/vim-jsonnet',
        ft = {'jsonnet'}
    }

    use {
        'Glench/Vim-Jinja2-Syntax',
        ft = 'jinja'
    }

    use {
        'hashivim/vim-terraform',
        ft = {'hcl', 'terraform'}
    }

    use {
        'christoomey/vim-tmux-navigator',
        cond = [[ require("my_config.utils").is_in_tmux() ]]
    }

end)
