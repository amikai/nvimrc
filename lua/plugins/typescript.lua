local pack = require("my_config.pack")

pack.add({ pack.gh("pmizio/typescript-tools.nvim") })

require("typescript-tools").setup({})
