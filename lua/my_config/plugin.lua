local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd vimball]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'sainnhe/gruvbox-material',
        setup = function()
            vim.g.gruvbox_material_background = 'soft'
        end,
        config = function()
            vim.cmd[[colorscheme gruvbox-material]]
        end
    }

    use {
         'luochen1990/rainbow',
        setup = function()
            vim.g.rainbow_active = 1
        end,
    }

    use { 'itchyny/vim-cursorword'}

    use {
        {
            'Yggdroot/indentLine',
            setup = function()
                vim.g.indentLine_fileTypeExclude = {'NvimTree', 'diff', 'tagbar', 'help'}
            end,
        },
        {
            'lukas-reineke/indent-blankline.nvim',
            branch = 'lua'
        }
    }

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
        setup = function()
            require('my_config.plugin.vim-matchup').setup()
        end,
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
      cmd = {'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull'}
    }

    use {
        'neovim/nvim-lspconfig',
        config = function()
            require('my_config.plugin.nvim-lspconfig').config()
        end
    }

    use {
        'hrsh7th/nvim-compe',
        config = function()
            require('my_config.plugin.nvim-compe').config()
        end
    }

    use {
        {
            'hrsh7th/vim-vsnip',
            setup = function()
                vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/vsnippets'
            end
        },
        {'hrsh7th/vim-vsnip-integ'}
    }

    use {
        'fatih/vim-go',
        ft = 'go',
        run = ':GoUpdateBinaries',
        setup = function()
            require('my_config.plugin.vim-go').setup()
        end,
        config = function()
            require('my_config.plugin.vim-go').config()
        end,

    }

    use {
        'stephpy/vim-yaml',
        ft = 'yaml'
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        cmd = 'Telescope'
    }

    use {
        'mhinz/vim-sayonara',
        cmd = 'Sayonara',
        setup = function()
            require('my_config.plugin.vim-sayonara').setup()
        end
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
        setup = function()
            require('my_config.plugin.undotree').setup()
        end,
        cmd = 'UndotreeToggle'
    }

    use {
        {'haya14busa/vim-asterisk'},
        {
            'haya14busa/is.vim',
            setup = function()
                require('my_config.plugin.is').setup()
            end
        },
        {
            'osyo-manga/vim-anzu',
            setup = function()
                require('my_config.plugin.vim-anzu').setup()
            end
        }
    }

    use {
        'ntpeters/vim-better-whitespace',
        setup = function()
            require('my_config.plugin.vim-better-whitespace').setup()
        end
    }

    use {
        'ronakg/quickr-cscope.vim',
        setup = function()
            require('my_config.plugin.quickr-cscope').setup()
        end
    }

    use {
        'junegunn/goyo.vim',
        setup = function()
            require('my_config.plugin.goyo').setup()
        end
    }

    use {
        'thinca/vim-qfreplace',
        cmd = {'Qfreplace'}
    }

    use {
        'justinmk/vim-sneak',
        setup = function()
            require('my_config.plugin.vim-sneak').setup()
        end
    }

    use {
        'mhinz/vim-signify',
        setup = function()
            require('my_config.plugin.vim-signify').setup()
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = 'TSUpdate',
        config = function()
            require('my_config.plugin.nvim-treesitter').config()
        end
    }

    use { 'pearofducks/ansible-vim' }

    use { 'google/vim-jsonnet' }
end)
