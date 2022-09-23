local M = {}

function M.setup()
    local util = require("formatter.util")
    require("formatter").setup({
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
            lua = {
                require("formatter.filetypes.lua").stylua,
                function()
                    return {
                        exe = "stylua",
                        args = {
                            "--search-parent-directories",
                            "--stdin-filepath",
                            util.escape_path(util.get_current_buffer_file_path()),
                            "--",
                            "indent-type Spaces",
                            "--",
                            "-",
                        },
                        stdin = true,
                    }
                end
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
