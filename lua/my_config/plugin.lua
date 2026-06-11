-- Plugins are managed by the built-in plugin manager (:h vim.pack).
-- Each module in lua/plugins/ installs its own plugins with vim.pack.add()
-- (through the my_config.pack helpers), defines its PackChanged build hooks,
-- and configures them right after. Update plugins with :lua vim.pack.update()
--
-- NOTE: when bootstrapping on a fresh machine, the very first vim.pack.add()
-- call installs everything from the lockfile at once (:h vim.pack-lockfile),
-- so a module's install hook may miss that initial install. Build artifacts
-- are recovered on demand (see plugins/telescope.lua) or by the hook on the
-- next plugin update.

local pack = require("my_config.pack")
local gh = pack.gh

-- Shared libraries used by several plugin modules below.
pack.add({
    gh("nvim-lua/plenary.nvim"),
    gh("nvim-lua/popup.nvim"),
    gh("nvim-tree/nvim-web-devicons"),
    gh("MunifTanjim/nui.nvim"),
})

-- Order matters: colorscheme and treesitter first, mason before lspconfig,
-- copilot before lspconfig (blink-copilot), telescope before yanky
-- (telescope extension).
require("plugins.colorscheme")
require("plugins.treesitter")
require("plugins.mason")
require("plugins.copilot")
require("plugins.lspconfig")
require("plugins.go-nvim")
require("plugins.rust")
require("plugins.typescript")
require("plugins.telescope")
require("plugins.yanky")
require("plugins.aerial")
require("plugins.ai")
require("plugins.autopair")
require("plugins.bufferline")
require("plugins.conform")
require("plugins.git")
require("plugins.gitsigns")
require("plugins.harpoon")
require("plugins.hlslens")
require("plugins.lualine")
require("plugins.nvim-lint")
require("plugins.nvim-tree")
require("plugins.snacks")
require("plugins.substitute")
require("plugins.suda")
require("plugins.ts-comments")
require("plugins.undotree")
require("plugins.vim-choosewin")
require("plugins.vim-matchup")
require("plugins.misc")
