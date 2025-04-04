return {
    'mfussenegger/nvim-lint',
    config = function(_, _)
        local lint = require('lint')
        lint.linters_by_ft = {
            go = { 'golangcilint' },
            json = { 'jsonlint' },
            gitcommit = { 'commitlint' },
            proto = { 'buf_lint' }
        }

        local commitlint = lint.linters.commitlint
        -- .commitlintrc.yaml is the config file of commitlint,
        -- See https://github.com/conventional-changelog/commitlint?tab=readme-ov-file#config
        commitlint.args = { '--config', vim.env.HOME .. "/" .. ".commitlintrc.yaml" }

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
