return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
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
                "windwp/nvim-autopairs",
                config = function()
                    require("nvim-autopairs").setup({})
                    local cmp = require("cmp")
                    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },
            {
                "zbirenbaum/copilot-cmp",
                dependencies = {
                    {
                        "zbirenbaum/copilot.lua",
                        config = function()
                            require("copilot").setup({
                                panel = {
                                    enabled = true,
                                    auto_refresh = true,
                                    layout = {
                                        position = "bottom", -- | top | left | right
                                        ratio = 0.3,
                                    },
                                },
                            })
                        end,
                    },
                },
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
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format(),
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
                    { name = "buffer" },
                }, {
                    { name = "buffer" },
                }),
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
            "williamboman/mason-lspconfig.nvim",
            "ray-x/lsp_signature.nvim",
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.set_sign_icons({
                error = '✗',
                warn = '!',
                hint = '',
                info = ''
            })

            lsp_zero.format_mapping('<F3>', {
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ['python'] = { 'pylsp' },
                    ['rust_analyzer'] = { 'rust' },
                }
            })
            -- on_attach attach on LspAttach event, so it will attach on all server start
            lsp_zero.on_attach(function(client, bufnr)
                require "lsp_signature".on_attach({ hint_prefix = "⚡ " }, bufnr)
                local km = require("my_config.utils").km_factory({ silent = true, buffer = bufnr })
                lsp_zero.default_keymaps({
                    buffer = bufnr,
                    exclude = { '<F2>', '<F4>', 'K', ']d', '[d' },
                })
                km('n', 'gR', vim.lsp.buf.rename)
                km("n", "<leader>ca", vim.lsp.buf.code_action)
                km("n", "<leader>wl", function()
                    vim.pretty_print(vim.lsp.buf.list_workspace_folders())
                end)


                -- See https://github.com/redhat-developer/yaml-language-server/issues/486
                if client.name == "yamlls" then
                    client.server_capabilities.documentFormattingProvider = true
                end
            end)

            require('mason-lspconfig').setup({
                ensure_installed = {
                    "clangd",
                    "ansiblels",
                    "pyright",
                    "dockerls",
                    "terraformls",
                    "html",
                    "bashls",
                    "lua_ls",
                    "vimls",
                    "yamlls",
                    "graphql",
                    "jsonls",
                    "tsserver",
                    "helm_ls",
                    "pylsp",
                    "typos_lsp",
                    -- delegate gopls, golang-lint-ci installation to go.nvim
                },
                handlers = {
                    -- gopls setting is in go.nvim
                    lsp_zero.default_setup, -- Mason will register the handler
                    clangd = function()
                        require('lspconfig').clangd.setup({
                            cmd = {
                                "clangd",
                                "--offset-encoding=utf-16",
                                "--fallback-style=webkit",
                            },
                        })
                    end,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                    pylsp = function()
                        -- Don't forget to PylspInstall python-lsp-ruff pyls-isort
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
