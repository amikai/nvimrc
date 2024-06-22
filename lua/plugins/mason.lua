return {
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        dependencies = {
            'williamboman/mason.nvim'
        },
        config = function()
            require('mason-tool-installer').setup {
                ensure_installed = {
                    "shfmt",
                    "actionlint",
                },
                auto_update = true,
                run_on_start = true,
                start_delay = 3000, -- 3 second delay
                debounce_hours = 5, -- at least 5 hours between attempts to install/update
                integrations = {
                    ['mason-lspconfig'] = true,
                    ['mason-null-ls'] = true,
                    ['mason-nvim-dap'] = true,
                },
            }
        end,
    }

}
