local pack = require("my_config.pack")

vim.g.choosewin_overlay_enable = 1

pack.add({ pack.gh("t9md/vim-choosewin") })

vim.keymap.set("n", "W", "<Plug>(choosewin)", { remap = true, silent = true })
