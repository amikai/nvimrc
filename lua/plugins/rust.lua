return {
    {
        'mrcjkb/rustaceanvim',
        version = '^3', -- Recommended
        ft = { 'rust' },
        config = function()
            vim.g.rustaceanvim = {
                -- Plugin configuration
                tools = {
                },
                -- LSP configuration
                server = {
                    cmd = {
                        "rustup",
                        "run",
                        "stable",
                        "rust-analyzer",
                    },
                    on_attach = function(client, bufnr)
                        -- you can also put keymaps in here
                    end,
                    settings = {
                        -- rust-analyzer language server configuration
                        ['rust-analyzer'] = {
                            checkOnSave = {
                                allFeatures = true,
                                overrideCommand = {
                                    "rustup",
                                    "run",
                                    "stable",
                                    "cargo-clippy",
                                    "--workspace",
                                    "--message-format=json-diagnostic-rendered-ansi",
                                    "--all-targets",
                                    "--all-features",
                                },
                            },
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
                },
                null_ls = {
                    enabled = true,
                    name = "Crates",
                },
            })
        end,
    },
}
