return {
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
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
                    cmd = function()
                        -- NOTE: copy from https://github.com/mrcjkb/rustaceanvim/blob/master/doc/mason.txt
                        -- use mason to manage the installation of rust-analyzer
                        local mason_registry = require('mason-registry')
                        -- trim trial newline
                        local ra_from_rustup = string.gsub(vim.fn.system("rustup which rust-analyzer"), '%s+', '')
                        -- try to use rust-analyzer from rustup first, then from
                        -- mason, finally from $PATH
                        local ra_binary = (vim.fn.executable('rustup') == 1 and ra_from_rustup)
                            or (mason_registry.is_installed('rust-analyzer')
                                -- This may need to be tweaked, depending on the operating system.
                                and require('mason.settings').current.install_root_dir .. "/bin/rust-analyzer"
                            ) or "rust-analyzer"
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
        "saecki/crates.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        event = { "BufRead Cargo.toml" },
        config = function()
            require("crates").setup({
                popup = {
                    autofocus = true,
                },
                completion = {
                    crates = {
                        enabled = true,
                    },
                },
                lsp = {
                    enabled = true,
                    actions = true,
                    completion = true,
                    hover = true,
                },
            })
        end,
    },
}
