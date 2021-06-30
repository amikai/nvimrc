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
        'Yggdroot/indentLine',
        setup = function()
            vim.g.indentLine_fileTypeExclude = {'nerdtree', 'diff', 'tagbar', 'help', 'defx'}
        end,
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
            vim.api.nvim_set_keymap('n', 'R', '<Plug>(operator-replace)', {})
        end
    }

    use {
        'andymass/vim-matchup',
        setup = function()
            vim.g.indentLine_fileTypeExclude = {'nerdtree', 'diff', 'tagbar', 'help', 'defx'}
            vim.g.matchup_matchparen_enabled = 1
            vim.g.matchup_surround_enabled = 1
            vim.g.matchup_matchparen_offscreen = { method = 'popup'}
            vim.g.matchup_transmute_enabled = 1
            vim.g.matchup_matchpref = { html = { tagnameonly = 1 }}
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
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        cmd = 'Telescope'
    }

end)
