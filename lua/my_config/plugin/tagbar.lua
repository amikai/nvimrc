local M = {}

local g = vim.g
local km = require("my_config.utils").km
local autocmd = vim.api.nvim_create_autocmd

function M.setup()
    km("n", "<F8>", "<cmd>TagbarToggle<cr>")

    autocmd("FileType", { pattern = "tagbar", callback = function()
        vim.opt_local.cursorline = false
        vim.opt_local.cursorcolumn = false
    end })

    g.tagbar_sort = 0
    g.tagbar_type_go = {
        ctagstype = "go",
        kinds = {
            "p:package",
            "i:imports:1",
            "c:constants",
            "v:variables",
            "t:types",
            "n:interfaces",
            "w:fields",
            "e:embedded",
            "m:methods",
            "r:constructor",
            "f:functions",
        },
        sro = ".",
        kind2scope = {
            t = "ctype",
            n = "ntype",
        },
        scope2kind = {
            ctype = "t",
            ntype = "n",
        },
        ctagsbin = "gotags",
        ctagsargs = "-sort -silent",
    }
end

return M
