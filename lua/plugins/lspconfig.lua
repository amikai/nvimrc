return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        -- use commit
        dependencies = {
            "j-hui/fidget.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local fn = vim.fn
            local autocmd = vim.api.nvim_create_autocmd
            local lspconfig = require("lspconfig")

            -- Change diagnostic signs.
            fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
            fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
            fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
            fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

            -- global config for diagnostic
            vim.diagnostic.config {
                underline = false,
                virtual_text = false,
                signs = true,
                severity_sort = true,
            }
            -- }}}

            local custom_attach = function(client, bufnr)
                local km = require("my_config.utils").km_factory({ silent = true, buffer = bufnr })


                -- See https://github.com/redhat-developer/yaml-language-server/issues/486
                if client.name == "yamlls" then
                    client.server_capabilities.documentFormattingProvider = true
                end

                km("n", "gd", vim.lsp.buf.definition)
                km("n", "K", vim.lsp.buf.hover)
                -- km("n", "<C-k>", vim.lsp.buf.signature_help)
                km("n", "gR", vim.lsp.buf.rename)
                km("n", "gr", vim.lsp.buf.references)
                km("n", "[d", vim.diagnostic.goto_prev)
                km("n", "]d", vim.diagnostic.goto_next)
                km("n", "gi", vim.lsp.buf.implementation)
                km("n", "gD", vim.lsp.buf.declaration)

                km("n", "<leader>ca", vim.lsp.buf.code_action)
                km("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
                km("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
                km("n", "<leader>wl", function()
                    vim.pretty_print(vim.lsp.buf.list_workspace_folders())
                end)

                if client.server_capabilities.documentFormattingProvider then
                    km("n", "<F3>", vim.lsp.buf.format)
                end

                if client.server_capabilities.documentRangeFormattingProvider then
                    -- FIXME
                    -- km("x", "<F3>", vim.lsp.buf.range_formatting)
                end


                -- auto format on save
                local fmt_fts = { "rust", "lua" }
                if client.server_capabilities.documentFormattingProvider then
                    autocmd("BufWritePre", { buffer = 0,
                        callback = function()
                            for _, ft in ipairs(fmt_fts) do
                                if vim.o.ft == ft then
                                    vim.lsp.buf.format()
                                end
                            end
                        end })
                end



                local msg = string.format("Language server %s started!", client.name)
                vim.api.nvim_echo({ { msg, "MoreMsg" } }, false, {})
            end

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            lspconfig.html.setup({
                on_attach = custom_attach,
                capabilities = capabilities,
            })

            lspconfig.jsonnet_ls.setup({
                on_attach = custom_attach,
                capabilities = capabilities,
            })

            lspconfig.terraformls.setup({
                on_attach = custom_attach,
                capabilities = capabilities,
            })

            lspconfig.dockerls.setup({
                on_attach = custom_attach,
                capabilities = capabilities,
            })

            lspconfig.ansiblels.setup({
                on_attach = custom_attach,
                capabilities = capabilities,
            })

            lspconfig.yamlls.setup({
                on_attach = custom_attach,
                capabilities = capabilities,
                settings = {
                    yaml = {
                        schemas = {
                            kubernetes = "*.k8s.yaml",
                        },
                    },
                },
            })

            lspconfig.lua_ls.setup({
                on_attach = custom_attach,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                fn.stdpath("config"),
                            },
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
                capabilities = capabilities,
            })

            lspconfig.bashls.setup({
                on_attach = custom_attach,
                capabilities = capabilities,
            })

            lspconfig.vimls.setup({
                on_attach = custom_attach,
                capabilities = capabilities,
            })

            lspconfig.pyright.setup({
                on_attach = custom_attach,
                capabilities = capabilities,
            })

            lspconfig.graphql.setup({
                on_attach = custom_attach,
                capabilities = capabilities,
            })

            -- see https://github.com/golang/tools/blob/master/gopls/doc/settings.md
            lspconfig.gopls.setup({
                cmd = { "gopls", "serve" },
                on_attach = function(client, bufnr)
                    local km = require("my_config.utils").km_factory({ silent = true, buffer = bufnr })
                    km("n", "K", vim.lsp.buf.hover)
                    km("n", "[d", vim.diagnostic.goto_prev)
                    km("n", "]d", vim.diagnostic.goto_next)

                    km("n", "<leader>ca", vim.lsp.buf.code_action)
                    km("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
                    km("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
                    km("n", "<leader>wl", function()
                        vim.pretty_print(vim.lsp.buf.list_workspace_folders())
                    end)

                    local msg = string.format("Language server %s started!", client.name)
                    vim.api.nvim_echo({ { msg, "MoreMsg" } }, false, {})
                end,
                capabilities = capabilities,
                settings = {
                    gopls = {
                        -- reference: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
                        gofumpt = true,
                        semanticTokens = true,
                        usePlaceholders = true,
                        experimentalPostfixCompletions = true,
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                    },
                },
            })

            lspconfig.golangci_lint_ls.setup({})
        end,
    }
}
