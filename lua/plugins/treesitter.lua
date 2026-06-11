local pack = require("my_config.pack")
local gh = pack.gh

-- Build hook (:h vim.pack-events)
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        end
    end,
})

pack.add({
    { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
    gh("nvim-treesitter/nvim-treesitter-context"),
    { src = gh("nvim-treesitter/nvim-treesitter-textobjects"), version = "main" },
    gh("HiPhish/rainbow-delimiters.nvim"),
    gh("RRethy/nvim-treesitter-endwise"),
})

pcall(function()
    require("nvim-treesitter.install").prefer_git = true
end)

require("treesitter-context").setup({
    enable = true,
})

require("rainbow-delimiters.setup").setup({})
