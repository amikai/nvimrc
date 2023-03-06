return {
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            vim.g.indent_blankline_disable_warning_message = true
            local exclude_ft = { "help", "git", "diff", "NvimTree", "vista" }
            require("indent_blankline").setup({
                -- U+2502 may also be a good choice, it will be on the middle of cursor.
                -- U+250A is also a good choice
                char = "▏",
                show_end_of_line = true,
                disable_with_nolist = true,
                filetype_exclude = exclude_ft,
                use_treesitter = true,
            })

            local gid = api.nvim_create_augroup("indent_blankline", { clear = true })
            api.nvim_create_autocmd("InsertEnter", {
                pattern = "*",
                group = gid,
                command = "IndentBlanklineDisable",
            })

            api.nvim_create_autocmd("InsertLeave", {
                pattern = "*",
                group = gid,
                callback = function()
                    if not vim.tbl_contains(exclude_ft, vim.bo.filetype) then
                        vim.cmd([[IndentBlanklineEnable]])
                    end
                end,
            })
        end,
    },
}
