local pack = require("my_config.pack")
local km = require("my_config.utils").km_factory({ silent = true })

pack.add({ pack.gh("akinsho/toggleterm.nvim") })

require("toggleterm").setup()

km({ "n", "t" }, "<F1>", "<cmd>ToggleTerm<cr>")
