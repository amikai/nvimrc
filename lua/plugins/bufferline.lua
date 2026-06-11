local pack = require("my_config.pack")

pack.add({ pack.gh("akinsho/bufferline.nvim") })

require("bufferline").setup({
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true,
            },
            {
                filetype = "aerial",
                text = "Symbol Outline",
                text_align = "center",
                separator = true,
            },
        },
    },
})
