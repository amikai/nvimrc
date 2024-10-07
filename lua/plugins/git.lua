return {
    {
        "tpope/vim-fugitive",
        cmd = { "G", "Git", "Gdiffsplit", "GBrowse" },
    },
    {
        "tpope/vim-rhubarb",
        init = function()
            vim.g.github_enterprise_urls = { 'https://adc.github.trendmicro.com' }
        end,
    },
    {
        "rbong/vim-flog",
        dependencies = "tpope/vim-fugitive",
        cmd = { "Flog" },
    },
    { "rhysd/committia.vim" },
}
