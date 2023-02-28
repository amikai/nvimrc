return {
    {
        "t9md/vim-choosewin",
        init = function()
            vim.g.choosewin_overlay_enable = 1
        end,
        keys = {
            { "W", "<Plug>(choosewin)", mode = "n" }
        },
    },
}
