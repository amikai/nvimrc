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
            -- vim.cmd[[colorscheme iceberg]]
        end
    }

    use {
        'Mofiqul/vscode.nvim',
        setup = function()
            vim.g.vscode_style = "dark"
        end,
        config = function()
            vim.cmd([[colorscheme vscode]])
        end
    }

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        cmd = {'Trouble', 'TroubleClose'},
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
        'lambdalisue/suda.vim',
        cmd = {'SudaRead', 'SudaWrite'}
    }

    use { 'itchyny/vim-cursorword'}

    use {
        'akinsho/toggleterm.nvim',
        cmd = 'ToggleTerm',
        setup = [[ require('my_config.plugin.toggleterm').setup() ]]
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        setup = function()
            vim.g.indent_blankline_disable_warning_message = true
            vim.g.indent_blankline_char = '┆'
            vim.g.indent_blankline_filetype_exclude = {'fern', 'diff', 'tagbar', 'help'}
        end
    }

    use {'PeterRincker/vim-searchlight'}

    use { 'machakann/vim-swap' }

    use {
        'kana/vim-textobj-user',
        {
            'glts/vim-textobj-comment',
            after = 'vim-textobj-user',
        },
        {
            'sgur/vim-textobj-parameter',
            after = 'vim-textobj-user',
        },

    }

    use {
        'kana/vim-operator-user',
        {
            'kana/vim-operator-replace',
            after = 'vim-operator-user',
            keys = {{'', '<Plug>(operator-replace)'}},
            setup = function()
                vim.api.nvim_set_keymap('', 'R', '<Plug>(operator-replace)', {})
            end
        },
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
        'tpope/vim-dispatch',
        cmd = {'Make', 'Dispatch'}
    }

    use {
      'tpope/vim-fugitive',
      cmd = {'Git', 'Gdiffsplit'}
    }

    use {
        "rbong/vim-flog",
        after = "vim-fugitive",
        cmd = { "Flog" }
    }

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
        'fatih/vim-go',
        run = ':GoUpdateBinaries',
        ft = 'go',
        setup = function()
            require('my_config.plugin.vim-go').setup()
        end,
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
        {
            'haya14busa/vim-asterisk',
            keys = {
                {'',  '<Plug>(asterisk-z*)<Plug>(is-nohl-1)'},
                {'',  '<Plug>(asterisk-z#)<Plug>(is-nohl-1)'},
                {'',  '<Plug>(asterisk-gz*)<Plug>(is-nohl-1)'},
                {'',  '<Plug>(asterisk-gz#)<Plug>(is-nohl-1)'},
            },
        },
        {
            'haya14busa/is.vim',
            after = 'vim-asterisk',
            setup = [[ require('my_config.plugin.is').setup() ]]
        },
        {
            'osyo-manga/vim-anzu',
            keys = {
                {'', '<Plug>(is-nohl)<Plug>(anzu-n-with-echo)zzzv'},
                {'', '<Plug>(is-nohl)<Plug>(anzu-N-with-echo)zzzv'},
            },
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
        'kevinhwang91/nvim-bqf',
        ft = 'qf'
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
        event = 'BufEnter',
        run = 'TSUpdate',
        config = [[ require('my_config.plugin.nvim-treesitter').config() ]]
    }

    use {
        'romgrk/nvim-treesitter-context',
        after = 'nvim-treesitter',
        config = function()
            require('my_config.plugin.nvim-treesitter-context').config()
        end
    }

    use {
        'p00f/nvim-ts-rainbow',
        after = 'nvim-treesitter'
    }

    use {
        'junegunn/fzf',
        run=':call fzf#install()'
    }

    use {
        'junegunn/fzf.vim'
    }

    use {
        'akinsho/bufferline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require("bufferline").setup{}
        end
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('lualine').setup{
            extensions = {
                'fern',
                'quickfix',
                'toggleterm',
                'fugitive',
            }
        }
      end
    }

    use {
        'preservim/tagbar',
        cmd = 'TagbarToggle',
        setup = [[ require('my_config.plugin.tagbar').setup() ]]
    }

    use {
        'lambdalisue/fern.vim',
        setup = function()
            vim.api.nvim_set_keymap('n', '<F4>', '<cmd>Fern . -drawer -toggle -width=30<cr>', {silent = true, noremap = true})
            vim.cmd [[autocmd FileType fern call my_config#fern#keymapping()]]
        end,
        config = function()
            vim.fn['my_config#fern#setting']()
        end,
        cmd = 'Fern'
    }

    use {
        'lambdalisue/fern-git-status.vim',
        after = 'fern.vim'
    }

    use {
        't9md/vim-choosewin',
        setup = [[ require('my_config.plugin.vim-choosewin').setup() ]],
        keys = {{'n', '<Plug>(choosewin)'}}
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
        ft = {'hcl', 'terraform'},
        setup = function()
            vim.g.terraform_fmt_on_save = 1
        end
    }

    use {
        'christoomey/vim-tmux-navigator',
        cond = [[ require("my_config.utils").is_in_tmux() ]]
    }

end)
