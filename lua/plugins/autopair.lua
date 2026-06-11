local pack = require("my_config.pack")
local gh = pack.gh

pack.add({
    gh("windwp/nvim-autopairs"),
    gh("windwp/nvim-ts-autotag"),
})

require("nvim-autopairs").setup({})
-- TODO: integrate into blink.cmp

require("nvim-ts-autotag").setup({
    opts = {
        -- Defaults
        enable_close = true,          -- Auto close tags
        enable_rename = true,         -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
    },
})
