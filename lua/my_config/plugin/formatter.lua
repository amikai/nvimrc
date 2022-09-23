local M = {}

function M.setup()
    local util = require("formatter.util")
    require("formatter").setup({
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
            lua = {
                require("formatter.filetypes.lua").stylua,
            },
            proto = {
                function()
                    return {
                        exe = "buf",
                        args = {
                            "format",
                            util.escape_path(util.get_current_buffer_file_path()),
                        },
                        stdin = true,
                    }
                end,
            },
        },
    })
end

return M
