local M = {}

local km = require("my_config.utils").km_factory({})
local hlslens = require("hlslens")
local utils = require("my_config.utils")

function M.config()
    hlslens.setup {
        calm_down = true,
        nearest_only = true,
    }

    local activate_hlslens = function(direction)
        local cmd = string.format("normal! %s%szzzv", vim.v.count1, direction)
        local status, msg = pcall(vim.cmd, cmd)


        if not status then
            -- 13 is the index where real error message starts
            msg = msg:sub(13)
            vim.api.nvim_err_writeln(msg)
            return
        end

        hlslens.start()
    end

    km("n", "n",
        function()
            activate_hlslens("n")
        end
    )

    km("n", "N",
        function()
            activate_hlslens("N")
        end
    )

    local activate_hlslen_asterisk = function(asterisk_key)
        local keyCodes = vim.api.nvim_replace_termcodes(asterisk_key, true, false, true)
        vim.api.nvim_feedkeys(keyCodes, 'im', false)
        hlslens.start()
    end

    km(
        { "n", "x" },
        "*",
        function()
            activate_hlslen_asterisk('<Plug>(asterisk-z*)')
        end
    )

    km(
        { "n", "x" },
        "#",
        function()
            activate_hlslen_asterisk('<Plug>(asterisk-z#)')
        end
    )

    km(
        { "n", "x" },
        "g*",
        function()
            activate_hlslen_asterisk('<Plug>(asterisk-gz*)')
        end
    )

    km(
        { "n", "x" },
        "g#",
        function()
            activate_hlslen_asterisk('<Plug>(asterisk-gz#)')
        end
    )
end

return M
