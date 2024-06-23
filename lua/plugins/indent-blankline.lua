return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            vim.g.indent_blankline_disable_warning_message = true
            local exclude_ft = { "help", "git", "diff", "NvimTree", "aerial" }
            require("ibl").setup({
                -- U+2502 may also be a good choice, it will be on the middle of cursor.
                -- U+250A is also a good choice
                indent = { char = "▏" },
                exclude = {
                    filetypes = exclude_ft,
                },
            })

            local gid = vim.api.nvim_create_augroup("indent_blankline", { clear = true })
            local autocmd = vim.api.nvim_create_autocmd
            autocmd("InsertEnter", {
                pattern = "*",
                group = gid,
                command = "IBLEnable",
            })

            autocmd("InsertLeave", {
                pattern = "*",
                group = gid,
                callback = function()
                    if not vim.tbl_contains(exclude_ft, vim.bo.filetype) then
                        vim.cmd([[IBLDisable]])
                    end
                end,
            })
        end,
    },
}
