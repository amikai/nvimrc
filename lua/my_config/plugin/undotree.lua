local M = {}

local km = vim.keymap.set

function M.setup()
    km("n", "<F6>", "<cmd>UndotreeToggle<cr>")
end

return M
