local pack = require("my_config.pack")
local gh = pack.gh

vim.g.github_enterprise_urls = { "https://adc.github.trendmicro.com" }

pack.add({
    gh("tpope/vim-fugitive"),
    gh("tpope/vim-rhubarb"),
    gh("rbong/vim-flog"),
    gh("rhysd/committia.vim"),
})
