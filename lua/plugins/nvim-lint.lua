return {
    'mfussenegger/nvim-lint',
    config = function(_, _)
        local lint = require('lint')
        lint.linters_by_ft = {
            go = { 'golangcilint' },
            json = { 'jsonlint' },
            gitcommit = { 'commitlint' },
        }

        -- golangci-lint config copy from https://github.com/mfussenegger/nvim-lint/blob/master/lua/lint/linters/golangcilint.lua
        local golangcilint = lint.linters.golangcilint
        golangcilint.append_fname = false
        golangcilint.args = {
            'run',
            "--no-config",
            '--out-format=json',
            '--show-stats=false',
            '--print-issued-lines=false',
            '--print-linter-name=false',
            "--disable-all",
            -- default option of golangci_lint
            "-E", "errcheck",
            "-E", "gosimple",
            "-E", "govet",
            "-E", "ineffassign",
            "-E", "staticcheck",
            "-E", "unused",
            -- logger check
            "-E", "sloglint",
            "-E", "loggercheck",
            -- lint prometheus metrics name
            "-E", "promlinter",
            -- lint the usage of testify
            "-E", "testifylint",
            -- computes the cyclomatic complexity
            "-E", "gocyclo",
            -- finds repeated strings that could be replaced by a constant.
            "-E", "goconst",
            -- others
            "-E", "revive",
            "-E", "bodyclose",
            "-E", "prealloc",
            "-E", "nestif",
            "-E", "nilerr",
            "-E", "nilnil",
            "-E", "gosec",
            function()
                -- NOTE: golangci-lint must be executed from the root path where the
                -- go.mod file is located. If the current working directory
                -- (cwd) is not the root path of the Golang project, it will
                -- not function correctly.
                -- NOTE: use relateive folder path of cwd (don't change that)
                return vim.fn.fnamemodify(vim.fn.expand('%'), ':.:h')
            end
        }
        -- The reason for copying the parser implementation is to ignore the
        -- typecheck linter, which gives useless diagnostics.
        golangcilint.parser = function(output, bufnr, cwd)
            if output == '' then
                return {}
            end
            local decoded = vim.json.decode(output)
            if decoded["Issues"] == nil or type(decoded["Issues"]) == 'userdata' then
                return {}
            end
            local severities = {
                error = vim.diagnostic.severity.ERROR,
                warning = vim.diagnostic.severity.WARN,
                refactor = vim.diagnostic.severity.INFO,
                convention = vim.diagnostic.severity.HINT,
            }

            local diagnostics = {}
            for _, item in ipairs(decoded["Issues"]) do
                if item.Pos and item.FromLinter ~= 'typecheck' then
                    local curfile = vim.api.nvim_buf_get_name(bufnr)
                    local lintedfile = cwd .. "/" .. item.Pos.Filename
                    if curfile == lintedfile then
                        table.insert(diagnostics, {
                            lnum = item.Pos.Line > 0 and item.Pos.Line - 1 or 0,
                            col = item.Pos.Column > 0 and item.Pos.Column - 1 or 0,
                            end_lnum = item.Pos.Line > 0 and item.Pos.Line - 1 or 0,
                            end_col = item.Pos.Column > 0 and item.Pos.Column - 1 or 0,
                            severity = severities[item.Severity] or severities.warning,
                            source = item.FromLinter,
                            message = item.Text,
                        })
                    end
                end
            end
            return diagnostics
        end

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
