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
                            filetype = "Outline",
                            text = "Outliner",
                            text_align = "center",
                            separator = true
                        }
                    },
                }
            })
        end,
    },
}
