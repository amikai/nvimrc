return {
    {
        "simrat39/rust-tools.nvim",
        lazy = true,
    },
    {
        "rust-lang/rust.vim",
        ft = "rust",
    },
    {
        "saecki/crates.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        event = { "BufRead Cargo.toml" },
        config = function()
            require("crates").setup({
                popup = {
                    autofocus = true,
                },
                null_ls = {
                    enabled = true,
                    name = "Crates",
                },
            })

        end,
    },
}
