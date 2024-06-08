return {
    'mfussenegger/nvim-lint',
    config = function(_, _)
        local lint = require('lint')
        lint.linters_by_ft = {
            go = { 'golangcilint' }
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
            "-E", "gosimple",
            "-E", "errcheck",
            "-E", "govet",
            "-E", "ineffassign",
            "-E", "staticcheck",
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
            function()
                -- NOTE: golangci-lint must be executed from the root path where the
                -- go.mod file is located. If the current working directory
                -- (cwd) is not the root path of the Golang project, it will
                -- not function correctly.
                -- NOTE: use relateive path of cwd (don't change that)
                return vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.')
            end
        }
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
                    table.insert(diagnostics, {
                        lnum = item.Pos.Line > 0 and item.Pos.Line - 1 or 0,
                        code = item.FromLinter,
                        col = item.Pos.Column > 0 and item.Pos.Column - 1 or 0,
                        end_lnum = item.Pos.Line > 0 and item.Pos.Line - 1 or 0,
                        end_col = item.Pos.Column > 0 and item.Pos.Column - 1 or 0,
                        severity = severities[item.Severity] or severities.warning,
                        source = item.FromLinter,
                        message = item.Text,
                    })
                end
            end
            return diagnostics
        end

        -- TODO: install actionlint and golangci-lint by mason-installer
        -- TODO: add trail space linter

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
