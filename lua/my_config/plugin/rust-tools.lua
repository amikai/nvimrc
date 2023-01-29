local M = {}

local km = require("my_config.utils").km_factory({ silent = true, buffer = true })
local rt = require("rust-tools")
local my_lsp = require('my_config.plugin.nvim-lspconfig')

function M.config()
    rt.setup({
        executor = require("rust-tools.executors").quickfix,
        server = {
            cmd = {
                "rustup", "run", "stable", "rust-analyzer",
            },
            on_attach = function(client, bufnr)
                my_lsp.custom_attach(client, bufnr)
                km("n", "K", rt.hover_actions.hover_actions)
                km("n", "<Leader>a", rt.code_action_group.code_action_group)
            end,
            capabilities = my_lsp.capabilities,
            settings = {
                ['rust-analyzer'] = {
                    checkOnSave = {
                        allFeatures = true,
                        overrideCommand = {
                            'rustup', 'run', 'stable', 'cargo-clippy', '--workspace',
                            '--message-format=json-diagnostic-rendered-ansi',
                            '--all-targets', '--all-features'
                        }
                    }
                }
            }
        },
    })
end

return M
