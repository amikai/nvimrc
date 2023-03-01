return {
    {
        "simrat39/rust-tools.nvim",
        config = function()
            local km = require("my_config.utils").km_factory({ silent = true, buffer = true })
            local rt = require("rust-tools")
            local custom_attach = require("my_config.utils").common_lsp_attach

            rt.setup({
                executor = require("rust-tools.executors").quickfix,
                server = {
                    cmd = {
                        "rustup",
                        "run",
                        "stable",
                        "rust-analyzer",
                    },
                    on_attach = function(client, bufnr)
                        custom_attach(client, bufnr)
                        km("n", "K", rt.hover_actions.hover_actions)
                        km("n", "<Leader>a", rt.code_action_group.code_action_group)
                    end,
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    settings = {
                        ["rust-analyzer"] = {
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
            })
        end,
        ft = "rust",
    },
    {
        "rust-lang/rust.vim",
        ft = "rust",
    },
}
