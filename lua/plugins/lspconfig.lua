return {
    {
        'saghen/blink.cmp',
        version = '*',
        event = 'InsertEnter',
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
                config = function()
                    -- blink's `luasnip` preset reads the LuaSnip registry instead
                    -- of the friendly-snippets JSON files, so the VSCode-style
                    -- snippets have to be registered with LuaSnip explicitly.
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
        opts = {
            -- See :h blink-cmp-config-keymap for defining your own keymap.
            -- <Tab> walks down the completion list like <C-n>, then jumps
            -- snippet placeholders when the menu is closed, then falls back to
            -- a literal tab. <S-Tab> is the mirror image. <CR> accepts, which
            -- comes from the `enter` preset.
            keymap = {
                preset = 'enter',
                ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            completion = {
                -- (Default) Only show the documentation popup when manually triggered
                documentation = { auto_show = false },

                -- Nothing is selected until <Tab> or <C-n> moves onto an item,
                -- and moving does not write the item into the buffer, so <CR>
                -- inserts a newline until a candidate is actually chosen.
                list = { selection = { preselect = false, auto_insert = false } },
            },

            -- Show the current function signature while typing (replaces
            -- lsp_signature.nvim).
            signature = { enabled = true },

            -- Expand and jump with LuaSnip rather than vim.snippet, so <Tab>
            -- and <S-Tab> walk the placeholders of LuaSnip-registered snippets.
            snippets = { preset = 'luasnip' },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    -- blink blocks the menu until every synchronous provider
                    -- answers, and the default budget is 2000ms. delance needs
                    -- several seconds for the first completion in a project
                    -- with large dependencies, which delayed the whole menu.
                    -- Treat the LSP provider as asynchronous after 200ms so the
                    -- fast sources render immediately and slower server results
                    -- merge in when they arrive.
                    lsp = { timeout_ms = 200 },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        }
    },
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            "b0o/schemastore.nvim",
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

            -- Default gh_actions_ls filetypes are `yaml` plus a workflow root_dir
            -- filter. We detect workflows as `yaml.github`, so override filetypes
            -- and leave yamlls on plain yaml.
            vim.lsp.config.gh_actions_ls = {
                filetypes = { "yaml.github" },
            }

            vim.lsp.config.jsonls = {
                settings = {
                    json = {
                        validate = { enable = true },
                        format = { enable = true },
                        schemaDownload = { enable = true },
                        schemas = require("schemastore").json.schemas(),
                    },
                },
            }

            -- Disable yamlls built-in SchemaStore; it conflicts with schemastore.nvim.
            vim.lsp.config.yamlls = {
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "",
                        },
                        schemas = require("schemastore").yaml.schemas(),
                    },
                },
            }

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
                    "gh_actions_ls",
                    "graphql",
                    "jsonls",
                    "helm_ls",
                    "typos_lsp",
                    "rust_analyzer",
                    -- "basedpyright",
                    "ruff",
                    -- Rust-based Python type checker, evaluated alongside delance.
                    "pyrefly",
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
