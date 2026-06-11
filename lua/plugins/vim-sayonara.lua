local pack = require("my_config.pack")
local km = require("my_config.utils").km_factory({ silent = true })

pack.add({ pack.gh("mhinz/vim-sayonara") })

km("n", "<leader>c", "<cmd>Sayonara!<cr>")
km("n", "<leader>q", "<cmd>Sayonara<cr>")
