local pack = require("my_config.pack")
local km = require("my_config.utils").km_factory({ silent = true })

pack.add({ pack.gh("mbbill/undotree") })

km("n", "<F6>", "<cmd>UndotreeToggle<cr>")
