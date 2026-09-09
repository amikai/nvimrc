local km = require("my_config.utils").km_factory({ silent = true })

return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("snacks").setup({
                -- LSP-based highlight of the word under cursor (replaces vim-illuminate)
                words = { enabled = true },
                -- Indent guides (replaces indent-blankline.nvim)
                indent = {
                    enabled = true,
                    animate = { enabled = false },
                    indent = { char = "▏" },
                    scope = { char = "▏" },
                },
                -- Fold/sign/number/git gutter (replaces statuscol.nvim)
                statuscolumn = {
                    enabled = true,
                    folds = { open = true },
                },
                zen = {
                    toggles = { dim = false },
                },
                styles = {
                    zen = { width = 100 },
                },
            })

            -- vim-sayonara replacements: <leader>c keeps the window (Sayonara!),
            -- <leader>q closes it too (Sayonara).
            km("n", "<leader>c", function()
                Snacks.bufdelete()
            end)
            km("n", "<leader>q", function()
                Snacks.bufdelete()
                vim.cmd.quit()
            end)

            -- toggleterm replacement
            km({ "n", "t" }, "<F1>", function()
                Snacks.terminal.toggle()
            end)

            -- zen-mode/twilight replacements
            km("n", "<F2>", function()
                Snacks.zen()
            end)
            Snacks.toggle.dim():map("<F50>")

            local gitbrowse_choices = { "repo", "branch", "file", "commit", "permalink" }
            vim.api.nvim_create_user_command("GitBrowse", function(opts)
                local what = opts.args ~= "" and vim.trim(opts.args) or nil
                local browse_opts = {
                    what = what,
                }
                if opts.range ~= 0 then
                    browse_opts.line_start = opts.line1
                    browse_opts.line_end = opts.line2
                end
                Snacks.gitbrowse(browse_opts)
            end, {
                desc = "Git Browse with Snacks.nvim",
                nargs = "?",
                range = true,
                complete = function(arg_lead)
                    return vim.tbl_filter(function(item)
                        return vim.startswith(item, arg_lead)
                    end, gitbrowse_choices)
                end,
            })

            -- Show indent guides only while inserting, as the old indent-blankline
            -- autocommands did.
            local gid = vim.api.nvim_create_augroup("my_config_snacks_indent", { clear = true })
            vim.api.nvim_create_autocmd("InsertEnter", {
                group = gid,
                callback = function()
                    Snacks.indent.enable()
                end,
            })
            vim.api.nvim_create_autocmd("InsertLeave", {
                group = gid,
                callback = function()
                    Snacks.indent.disable()
                end,
            })

            -- By default the indent scope guide links to Special, which in iceberg is
            -- the same blue as the gitsigns change bar; use muted grays instead so the
            -- guides can't be confused with git change indicators.
            local function set_indent_hl()
                vim.api.nvim_set_hl(0, "SnacksIndent", { ctermfg = 237, fg = "#2e313f" })
                vim.api.nvim_set_hl(0, "SnacksIndentScope", { ctermfg = 242, fg = "#6b7089" })
            end
            set_indent_hl()
            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "iceberg",
                callback = set_indent_hl,
            })

            -- Snacks.words highlights through the standard LSP reference groups; port the
            -- old IlluminatedWord* colors for iceberg.
            local function set_reference_hl()
                for _, group in ipairs({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }) do
                    vim.api.nvim_set_hl(0, group, {
                        ctermfg = 251,
                        ctermbg = 236,
                        fg = "#c6c8d1",
                        bg = "#3d425b",
                    })
                end
            end
            set_reference_hl()
            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "iceberg",
                callback = set_reference_hl,
            })
        end,
    },
}
