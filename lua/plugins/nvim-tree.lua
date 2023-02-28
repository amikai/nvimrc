return {
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {
            'kyazdani42/nvim-web-devicons',
        },
        tag = 'nightly',
        cmd = 'NvimTreeToggle',
        keys = {
            { "<F4>", "<cmd>NvimTreeToggle<cr>", mode = "n", { silent = true } }
        },
        config = function()
            require("nvim-tree").setup({
                git = {
                    enable = false,
                },
            })
        end,
    },
}
