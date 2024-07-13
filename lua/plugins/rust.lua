return {
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        lazy = false,   -- This plugin is already lazy
        setup = function()
            vim.g.rustaceanvim = {
                -- Plugin configuration
                tools = {
                    enable_nextest = true,
                    enable_clippy = true,
                    reload_workspace_from_cargo_toml = true,
                },
                -- LSP configuration
                server = {
                    cmd = function()
                        -- use mason to manage the installation of rust-analyzer
                        local mason_registry = require('mason-registry')
                        local ra_binary = mason_registry.is_installed('rust-analyzer')
                            -- This may need to be tweaked, depending on the operating system.
                            and mason_registry.get_package('rust-analyzer'):get_install_path() .. "/rust-analyzer"
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
