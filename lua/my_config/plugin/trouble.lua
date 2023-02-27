local M = {}

local km = require("my_config.utils").km

function M.setup()
    km(
        "n",
        "<F9>",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true }
    )
end

function M.config()
    require("trouble").setup({})
    km(
        "n",
        "[d",
        "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<CR>",
        { silent = true }
    )

    km(
        "n",
        "]d",
        "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<CR>",
        { silent = true }
    )

end

return M
