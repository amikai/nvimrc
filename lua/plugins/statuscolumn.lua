return {
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                segments = {
                    { text = { builtin.foldfunc } },
                    { sign = { name = { "Diagnostic" }, maxwidth = 1, auto = true } },
                    { text = { builtin.lnumfunc } },
                    { text = { " " } },
                    { sign = { name = { "GitSigns" }, maxwidth = 1, colwidth = 1, auto = false } },
                }
            })
        end
    }
}
