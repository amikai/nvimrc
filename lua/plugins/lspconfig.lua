return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        config = false,
    },
    {
        -- The author of hrsh7th/nvim-cmp is currently too busy to maintain the
        -- project. Therefore, it's advisable to use a forked version for a
        -- better user experience.
        'iguanacucumber/magazine.nvim',
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
            local lsp_attach = function(client, bufnr)
                require "lsp_signature".on_attach({ hint_prefix = "⚡ " }, bufnr)
                local km = require("my_config.utils").km_factory({ silent = true, buffer = bufnr })

                km('n', 'gR', vim.lsp.buf.rename)
                km("n", "<leader>ca", vim.lsp.buf.code_action)
                km("n", "<leader>wl", function()
                    vim.print(vim.lsp.buf.list_workspace_folders())
                end)
                lsp_zero.default_keymaps({
                    buffer = bufnr,
                    -- When set to preserve_mappings to true,lsp-zero will not
                    -- override your existing keybindings.
                    preserve_mappings = true
                })
            end
            -- This is where all the LSP shenanigans will live
            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })

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
                    "ts_ls",
                    "helm_ls",
                    "pylsp",
                    "typos_lsp",
                    "rust_analyzer"
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
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
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
