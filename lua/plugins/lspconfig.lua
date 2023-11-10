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
            vim.diagnostic.config({
                underline = false,
                virtual_text = true,
                signs = true,
                severity_sort = true,
            })


            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.set_sign_icons({
                error = '✗',
                warn = '!',
                hint = '',
                info = ''
            })

            -- on_attach attach on LspAttach event, so it will attach on all server start
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                local km = require("my_config.utils").km_factory({ silent = true, buffer = bufnr })
                lsp_zero.default_keymaps({
                    buffer = bufnr,
                    exclude = { '<F2>', '<F4>', 'K' },
                })
                km('n', 'gR', vim.lsp.buf.rename)
                km("n", "<leader>ca", vim.lsp.buf.code_action)
                km("n", "<leader>wl", function()
                    vim.pretty_print(vim.lsp.buf.list_workspace_folders())
                end)
                require "lsp_signature".on_attach({ hint_prefix = "⚡ " }, bufnr)

                if client.server_capabilities.documentFormattingProvider then
                    local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
                    if ft == "go" then
                        km("n", "<F3>", require("go.format").goimport)
                    else
                        km("n", '<F3>', "<Cmd>lua vim.lsp.buf.format({async = true})<CR>")
                    end
                end

                -- See https://github.com/redhat-developer/yaml-language-server/issues/486
                if client.name == "yamlls" then
                    client.server_capabilities.documentFormattingProvider = true
                end


                local function show_documentation()
                    local filetype = vim.bo.filetype
                    local path = vim.api.nvim_buf_get_name(bufnr)
                    if vim.tbl_contains({ "vim", "help" }, filetype) then
                        vim.cmd("h " .. vim.fn.expand("<cword>"))
                    elseif vim.tbl_contains({ "man" }, filetype) then
                        vim.cmd("Man " .. vim.fn.expand("<cword>"))
                    elseif vim.fn.fnamemodify(path, ":t") == "Cargo.toml" and require("crates").popup_available() then
                        -- use crates.nvim
                        require("crates").show_popup()
                    elseif client.server_capabilities.hoverProvider then
                        vim.lsp.buf.hover()
                    end
                end
                vim.keymap.set("n", "K", show_documentation, { buffer = bufnr })

                local msg = string.format("Language server %s started!", client.name)
                vim.api.nvim_echo({ { msg, "MoreMsg" } }, false, {})
            end)

            require('mason-lspconfig').setup({
                ensure_installed = {
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
                    "pylsp"
                    -- delegate rust-analyzer installation to rustup
                    -- delegate gopls, golang-lint-ci installation to go.nvim
                },
                handlers = {
                    lsp_zero.default_setup, -- Mason will register the handler
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                    rust_analyzer = function()
                        -- (Optional) Configure rust-analyzer for neovim
                        local km = require("my_config.utils").km_factory({ silent = true, buffer = true })
                        local rt = require("rust-tools")

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

                        -- format on save
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            pattern = "*.rs",
                            callback = function()
                                vim.lsp.buf.format()
                            end,
                        })
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
                                        -- python-lsp-ruff doesn't support format now, so using black instead
                                        -- See detail in https://github.com/python-lsp/python-lsp-ruff/issues/53
                                        black = { enabled = false },
                                        ruff = {
                                            enabled = true,
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
