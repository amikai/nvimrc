return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        config = false,
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "rafamadriz/friendly-snippets",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            {
                "zbirenbaum/copilot-cmp",
                dependencies = { "zbirenbaum/copilot.lua" },
                config = function()
                    require("copilot_cmp").setup({
                        event = { "InsertEnter", "LspAttach" },
                        fix_pairs = true,
                    })
                end,
            },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("my_config.luasnip.go")

            cmp.setup({
                formatting = lsp_zero.cmp_format({ details = true }),
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = false,
                    }),
                    ['<Tab>'] = cmp_action.luasnip_supertab(),
                    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                }),
                sources = cmp.config.sources({
                    { name = "copilot" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                }, {
                    { name = "buffer" },
                }),
                snippet = {
                    expand = function(args)
                        require 'luasnip'.lsp_expand(args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })

            cmp.event:on("menu_opened", function()
                vim.b.copilot_suggestion_hidden = true
            end)

            cmp.event:on("menu_closed", function()
                vim.b.copilot_suggestion_hidden = false
            end)

            -- for creates.nvim
            vim.api.nvim_create_autocmd("BufRead", {
                group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
                pattern = "Cargo.toml",
                callback = function()
                    cmp.setup.buffer({
                        sources = {
                            { name = "crates" },
                        },
                    })
                end,
            })

            -- auto completion in search mode
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- auto completion in cmd mode
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' }
                        }
                    }
                })
            })
        end,
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
            local lsp_zero = require('lsp-zero')
            -- This is where all the LSP shenanigans will live
            lsp_zero.extend_lspconfig({
                sign_text = true,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })

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
                    -- python
                    "pylsp",
                    "pyright",
                    "pylyzer"
                },
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                    ["gopls"] = lsp_zero.noop,         -- delegate the handler to go.nvim
                    ["rust_analyzer"] = lsp_zero.noop, -- delegate the handle to rustaceanvim
                    ["clangd"] = function()
                        require('lspconfig').clangd.setup({
                            cmd = {
                                "clangd",
                                "--offset-encoding=utf-16",
                                "--fallback-style=webkit",
                            },
                        })
                    end,
                    ["lua_ls"] = function()
                        -- (Optional) Configure lua language server for neovim
                        --
                        require('lspconfig').lua_ls.setup({
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
                        })
                    end,
                    ["pylsp"] = function()
                        -- Don't forget to PylspInstall python-lsp-ruff pyls-isort
                        -- See the setting in https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
                        require('lspconfig').pylsp.setup {
                            settings = {
                                pylsp = {
                                    plugins = {
                                        -- formatter options
                                        rope_autoimport = { enabled = true },
                                        autopep8 = { enabled = false },
                                        yapf = { enabled = false },
                                        -- linter options
                                        pylint = { enabled = false },
                                        black = { enabled = false },
                                        ruff = {
                                            enabled = true,
                                            formatEnabled = true,
                                            select = {
                                                -- See ruff linter
                                                "E", "F", "PL"
                                            }
                                        },
                                        pyflakes = { enabled = false },
                                        pycodestyle = { enabled = false },
                                        -- type checker
                                        pylsp_mypy = {
                                            enabled = true,
                                            report_progress = true,
                                            live_mode = false
                                        },
                                        -- auto-completion options
                                        jedi_completion = { fuzzy = true },
                                        -- import sorting
                                        isort = { enabled = true },
                                    },
                                },
                            },
                            flags = {
                                debounce_text_changes = 200,
                            },
                        }
                    end
                },
                automatic_installation = true,
            })
        end
    }
}
