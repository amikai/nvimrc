return {
    {
        'saghen/blink.cmp',
        event = 'InsertEnter',
        dependencies = {
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "fang2hou/blink-copilot",
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

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'copilot', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },
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
            {
                "williamboman/mason-lspconfig.nvim",
                dependencies = {
                    'williamboman/mason.nvim'
                }
            },
            "ray-x/lsp_signature.nvim",
        },
        config = function()
            -- TODO: tune the pyright setting in uv project
            vim.lsp.config.pyright = {
                settings = {
                    python = {
                        venvPath = vim.fn.getcwd() .. '.venv'
                    }
                }
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
                ensure_installed = {
                    "clangd",
                    "ansiblels",
                    "dockerls",
                    "terraformls",
                    "html",
                    "bashls",
                    "lua_ls",
                    "vimls",
                    "yamlls",
                    "graphql",
                    "jsonls",
                    "ts_ls",
                    "helm_ls",
                    "typos_lsp",
                    "rust_analyzer",
                    "pyright",
                    "basedpyright",
                    "ruff",
                    "pylyzer"
                },
            })
        end
    }
}
