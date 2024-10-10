return {
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false,   -- This plugin is already lazy
        init = function()
            vim.g.rustaceanvim = {
                -- Plugin configuration
                tools = {
                    enable_nextest = true,
                    enable_clippy = true,
                    reload_workspace_from_cargo_toml = true,
                },
                -- LSP configuration
                server = {
                    -- disable loading vscode settings
                    load_vscode_settings = 0,
                    on_attach = function(client, bufnr)
                        local km = require("my_config.utils").km_factory({ silent = true, buffer = bufnr })
                        local lsp_zero = require('lsp-zero')

                        km('n', 'gR', vim.lsp.buf.rename)
                        km("n", "<leader>ca", vim.lsp.buf.code_action)
                        km("n", "<leader>wl", function()
                            vim.pretty_print(vim.lsp.buf.list_workspace_folders())
                        end)
                        lsp_zero.default_keymaps({
                            buffer = bufnr,
                            -- When set to preserve_mappings to true,lsp-zero will not
                            -- override your existing keybindings.
                            preserve_mappings = true
                        })
                    end,
                    cmd = function()
                        -- NOTE: copy from https://github.com/mrcjkb/rustaceanvim/blob/master/doc/mason.txt
                        -- use mason to manage the installation of rust-analyzer
                        local mason_registry = require('mason-registry')
                        local ra_binary = mason_registry.is_installed('rust-analyzer')
                            -- This may need to be tweaked, depending on the operating system.
                            and require('mason.settings').current.install_root_dir .. "/bin/rust-analyzer"
                            or "rust-analyzer"
                        return { ra_binary } -- You can add args to the list, such as '--log-file'
                    end,
                    settings = {
                        -- See https://rust-analyzer.github.io/manual.html
                        ['rust-analyzer'] = {
                            imports = {
                                granularity = {
                                    group = "module",
                                },
                                prefix = "crate",
                            },
                            checkOnSave = true,

                        },
                    },
                },
                -- DAP configuration
                dap = {
                },
            }
        end
    },
    {
        "rust-lang/rust.vim",
        ft = "rust",
    },
    {
        "saecki/crates.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        event = { "BufRead Cargo.toml" },
        config = function()
            require("crates").setup({
                popup = {
                    autofocus = true,
                }
            })
        end,
    },
}
