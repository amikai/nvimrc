return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        config = function()
            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local feedkey = function(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    end,
                },
                mapping = {
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        elseif vim.fn["vsnip#available"](1) == 1 then
                            feedkey("<Plug>(vsnip-expand-or-jump)", "")
                        elseif has_words_before() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.fn["vsnip#jumpable"]( -1) == 1 then
                            feedkey("<Plug>(vsnip-jump-prev)", "")
                        end
                    end, { "i", "s" }),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = false,
                    }),
                },
                sources = cmp.config.sources({
                    { name = "copilot" },
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
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
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "rafamadriz/friendly-snippets",
            "hrsh7th/vim-vsnip",
            "hrsh7th/cmp-cmdline",
            {
                "windwp/nvim-autopairs",
                config = function()
                    require("nvim-autopairs").setup({})
                    local cmp = require("cmp")
                    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },
        },
    },
}
