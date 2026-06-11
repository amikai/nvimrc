local pack = require("my_config.pack")
local km = require("my_config.utils").km_factory({ silent = true })

pack.add({
    { src = pack.gh("ThePrimeagen/harpoon"), version = "harpoon2" },
})

km("n", "<leader><leader>", [[<cmd>lua require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())<cr>]])
km("n", "<leader>a", [[<cmd>lua require("harpoon"):list():add()<cr>]])
km("n", "[h", [[<cmd>lua require("harpoon"):list():prev()<cr>]])
km("n", "]h", [[<cmd>lua require("harpoon"):list():next()<cr>]])
