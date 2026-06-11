local pack = require("my_config.pack")
local km = require("my_config.utils").km_factory({ silent = true })

pack.add({ pack.gh("stevearc/aerial.nvim") })

require("aerial").setup({
    layout = {
        min_width = 25,
        max_width = 25,
    },
    nerd_font = false,
})

km("n", "<F8>", "<cmd>AerialToggle<cr>")
