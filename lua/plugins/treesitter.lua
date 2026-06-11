local pack = require("my_config.pack")
local gh = pack.gh

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
