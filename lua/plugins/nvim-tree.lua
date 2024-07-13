return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    cmd = "NvimTreeToggle",
    keys = {
        { "<F4>", "<cmd>NvimTreeToggle<cr>", mode = "n", { silent = true } },
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {
            git = {
                enable = false,
            },
            filesystem_watchers = {
                ignore_dirs = function(path)
                    -- ignore the target folder in rust folder
                    -- nvim-tree watches for changes in all files. When
                    -- rust-analyzer is running, it changes a bunch of files in
                    -- its target folder, uses a lot of memory, and slows down
                    -- the computer.
                    if vim.fn.getcwd() .. "/Cargo.toml" and path == vim.fn.getcwd() .. "/target" then
                        return true
                    end
                end
            },
        }
    end,
}
