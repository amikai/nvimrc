return {
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "Gdiffsplit" },
    },
    {
        "rbong/vim-flog",
        dependencies = "tpope/vim-fugitive",
        cmd = { "Flog" },
    },
    { "rhysd/committia.vim" },
}
