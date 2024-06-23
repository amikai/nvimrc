return {
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                ft_ignore = { "NvimTree", "aerial" },
                segments = {
                    { text = { builtin.foldfunc } },
                    { sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true } },
                    { text = { builtin.lnumfunc } },
                    { text = { " " } },
                    { sign = { namespace = { "gitsigns" }, colwidth = 1, wrap = true } },
                }
            })
        end
    }
}
