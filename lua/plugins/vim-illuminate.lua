return {
    "RRethy/vim-illuminate",
    dependencies = "nvim-treesitter",
    config = function()
        require("illuminate").configure({
            -- providers: provider used to get references in the buffer, ordered by priority
            providers = {
                "lsp",
                "treesitter",
                "regex",
            },
            delay = 100,
            filetypes_denylist = { "help", "git", "diff", "NvimTree", "aerial" },
            -- large_file_cutoff: number of lines at which to use large_file_config
            -- The `under_cursor` option is disabled when this cutoff is hit
            large_file_cutoff = 2000,
            -- large_file_config: config to use for large files (based on large_file_cutoff).
            -- Supports the same keys passed to .configure
            -- If nil, vim-illuminate will be disabled for large files.
            large_file_overrides = nil,
            -- min_count_to_highlight: minimum number of matches required to perform highlighting
            min_count_to_highlight = 1,
        })

        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "iceberg",
            callback = function()
                -- ctermfg=251 ctermbg=236 guifg=#c6c8d1 guibg=#3d425b
                vim.api.nvim_set_hl(0, 'IlluminatedWordText', {
                    ctermfg = 251,
                    ctermbg = 236,
                    fg = "#c6c8d1",
                    bg = "#3d425b"
                })
                vim.api.nvim_set_hl(0, 'IlluminatedWordRead', {
                    ctermfg = 251,
                    ctermbg = 236,
                    fg = "#c6c8d1",
                    bg = "#3d425b"
                })
                vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', {
                    ctermfg = 251,
                    ctermbg = 236,
                    fg = "#c6c8d1",
                    bg = "#3d425b"
                })
            end,
        })
    end,
}
