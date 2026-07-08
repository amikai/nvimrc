return {
    {
        'saghen/blink.cmp',
        version = '*',
        event = 'InsertEnter',
        dependencies = {
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
        opts = {
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'enter' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Show the current function signature while typing (replaces
            -- lsp_signature.nvim).
            signature = { enabled = true },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        }
    },
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            {
                "mason-org/mason-lspconfig.nvim",
                dependencies = {
                    'mason-org/mason.nvim'
                }
            },
        },
        config = function()
            vim.lsp.config('*', {
                root_markers = { '.git' },
            })

            -- vim.lsp.config.basedpyright = {
            --     settings = {
            --         python = {
            --             pythonPath = require("my_config.utils").get_py_path(),
            --         },
            --     },
            --     root_markers = { "pyproject.toml", ".venv" },
            -- }

            -- delance-langserver is a Pyright/Pylance fork installed outside of mason
            -- (npm i -g @delance/runtime), so it has no entry in
            -- mason-lspconfig and must be enabled explicitly below.
            vim.lsp.config.delance = {
                cmd = { "delance-langserver", "--stdio" },
                filetypes = { "python" },
                root_markers = { "pyproject.toml", ".venv" },
                init_options = vim.empty_dict(),
                settings = {
                    python = {
                        pythonPath = require("my_config.utils").get_py_path(),
                        analysis = {
                            typeCheckingMode = "basic",
                            diagnosticMode = "openFilesOnly",
                            stubPath = "./typings",
                            autoSearchPaths = true,
                            extraPaths = {},
                            diagnosticSeverityOverrides = vim.empty_dict(),
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            }
            vim.lsp.enable("delance")

            vim.lsp.config.lua_ls = {
                settings = {
                    format = {
                        enable = true,
                        -- Put format options here
                        -- NOTE: the value should be String!
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "4",
                        }
                    },
                    Lua = {
                        telemetry = {
                            enable = false
                        },
                    },
                },
                on_init = function(client)
                    local join = vim.fs.joinpath
                    local path = client.workspace_folders[1].name

                    -- Don't do anything if there is project local config
                    if vim.uv.fs_stat(join(path, '.luarc.json'))
                        or vim.uv.fs_stat(join(path, '.luarc.jsonc'))
                    then
                        return
                    end

                    local nvim_settings = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' }
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                -- Make the server aware of Neovim runtime files
                                vim.env.VIMRUNTIME,
                                vim.fn.stdpath('config'),
                            },
                        },
                    }

                    client.config.settings.Lua = vim.tbl_deep_extend(
                        'force',
                        client.config.settings.Lua,
                        nvim_settings
                    )
                end,
            }

            require('mason-lspconfig').setup({
                -- These LSP tools will enable vim.lsp through their plugin.
                automatic_enable = {
                    exclude = { "rust_analyzer", "gopls" }
                },
                ensure_installed = {
                    "gopls",
                    "clangd",
                    "ansiblels",
                    "dockerls",
                    "terraformls",
                    "bashls",
                    "lua_ls",
                    "vimls",
                    "yamlls",
                    "graphql",
                    "jsonls",
                    "helm_ls",
                    "typos_lsp",
                    "rust_analyzer",
                    -- "basedpyright",
                    "ruff",
                    -- front end dev
                    "vtsls",
                    "html",
                    "tailwindcss",
                    -- Use ESLint and Biome as LSPs instead of linter command in
                    -- nvim-lint. This setup is easier to configure because it
                    -- supports many file types and can automatically detect
                    -- them.
                    "eslint",
                    "biome"
                },
            })
        end
    }
}
