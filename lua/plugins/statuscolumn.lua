local pack = require("my_config.pack")

pack.add({ pack.gh("luukvbaal/statuscol.nvim") })

local builtin = require("statuscol.builtin")
require("statuscol").setup({
    ft_ignore = { "NvimTree", "aerial" },
    segments = {
        { text = { builtin.foldfunc } },
        { sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true } },
        { text = { builtin.lnumfunc } },
        { text = { " " } },
        { sign = { namespace = { "gitsigns" }, colwidth = 1, wrap = true } },
    },
})
