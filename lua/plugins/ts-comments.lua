local pack = require("my_config.pack")

pack.add({ pack.gh("folke/ts-comments.nvim") })

require("ts-comments").setup({})
