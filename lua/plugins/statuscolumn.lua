return {
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                ft_ignore = { "NvimTree", "Outline" },
                segments = {
                    { text = { builtin.foldfunc } },
                    { sign = { name = { "Diagnostic" }, maxwidth = 1, auto = true } },
                    { text = { builtin.lnumfunc } },
                    { text = { " " } },
                    { sign = { namespace = { "gitsigns" }, colwidth = 1, wrap = true } },
                }
            })
        end
    }
}
