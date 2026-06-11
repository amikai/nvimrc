local pack = require("my_config.pack")
local km = require("my_config.utils").km_factory({ silent = true })

pack.add({ pack.gh("gbprod/substitute.nvim") })

require("substitute").setup({})

km({ "n", "x" }, "R", "<cmd>lua require('substitute').operator()<cr>")
km("n", "RR", "<cmd>lua require('substitute').line()<cr>")
km("n", "cx", "<cmd>lua require('substitute.exchange').operator()<cr>")
