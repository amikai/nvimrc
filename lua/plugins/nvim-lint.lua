return {
    'mfussenegger/nvim-lint',
    config = function(_, _)
        local lint = require('lint')
        lint.linters_by_ft = {
            -- See the detail config of golangci-lint in $HOME/.golangci.yaml
            go = { 'golangcilint' },
            json = { 'jsonlint' },
            proto = { 'buf_lint' }
        }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufRead" }, {
            callback = function()
                require("lint").try_lint()
                local fname = vim.api.nvim_buf_get_name(0)
                -- check the file exists and the path contains ".github/workflows/"
                if vim.uv.fs_stat(fname) and string.find(fname, "%.github/workflows/") then
                    require("lint").try_lint("actionlint")
                end
            end,
        })
    end
}
