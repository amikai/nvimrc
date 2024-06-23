return {
    {
        "akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({
                options = {
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "center",
                            separator = true
                        },
                        {
                            filetype = "aerial",
                            text = "Symbol Outline",
                            text_align = "center",
                            separator = true
                        }
                    },
                }
            })
        end,
    },
}
