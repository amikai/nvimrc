-- Plugins are managed by the built-in plugin manager (:h vim.pack).
-- Each module in lua/plugins/ installs its own plugins with vim.pack.add()
-- (through the my_config.pack helpers) and configures them right after.
-- Update plugins with :lua vim.pack.update()

local pack = require("my_config.pack")
local gh = pack.gh

-- Build hooks, keyed by plugin name. PackChanged autocommands must exist
-- before the vim.pack.add() call that installs the plugin, so this stays at
-- the top of this file (:h vim.pack-events).
local build = {
    ["telescope-fzf-native.nvim"] = function(ev)
        vim.system({ "make" }, { cwd = ev.data.path }):wait()
    end,
    ["CopilotChat.nvim"] = function(ev)
        vim.system({ "make", "tiktoken" }, { cwd = ev.data.path }):wait()
    end,
    ["nvim-treesitter"] = function(ev)
        if not ev.data.active then
            vim.cmd.packadd("nvim-treesitter")
        end
        vim.cmd("TSUpdate")
    end,
    ["go.nvim"] = function(ev)
        -- Only on update: at first install the Go binaries are better
        -- installed on demand with :GoInstallBinaries.
        if ev.data.kind ~= "update" then
            return
        end
        if not ev.data.active then
            vim.cmd.packadd("guihua.lua")
            vim.cmd.packadd("go.nvim")
        end
        require("go.install").update_all_sync()
    end,
}

vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("my_config_pack_build", { clear = true }),
    callback = function(ev)
        if ev.data.kind == "delete" then
            return
        end
        local hook = build[ev.data.spec.name]
        if not hook then
            return
        end
        local ok, err = pcall(hook, ev)
        if not ok then
            vim.notify(
                string.format("Build hook for %s failed: %s", ev.data.spec.name, err),
                vim.log.levels.WARN
            )
        end
    end,
})

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
require("plugins.indent-blankline")
require("plugins.lualine")
require("plugins.nvim-lint")
require("plugins.nvim-tree")
require("plugins.statuscolumn")
require("plugins.substitute")
require("plugins.suda")
require("plugins.toggleterm")
require("plugins.ts-comments")
require("plugins.undotree")
require("plugins.vim-choosewin")
require("plugins.vim-illuminate")
require("plugins.vim-matchup")
require("plugins.vim-sayonara")
require("plugins.zen-mode")
require("plugins.misc")
