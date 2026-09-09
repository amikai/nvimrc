return {
    'mfussenegger/nvim-lint',
    config = function(_, _)
        local lint = require('lint')
        lint.linters_by_ft = {
            -- See the detail config of golangci-lint in $HOME/.golangci.yaml
            go = { "golangcilint" },
            json = { "jsonlint" },
            proto = { "buf_lint" },
            ["yaml.github"] = { "actionlint" },
        }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufRead" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end
}
