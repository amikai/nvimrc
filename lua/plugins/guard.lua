return {
    "nvimdev/guard.nvim",
    -- Builtin configuration, optional
    enabled = false,
    dependencies = {
        "nvimdev/guard-collection",
    },
    config = function()
        local golangcilint = require("guard-collection.linter.golangci_lint")
        -- disable type-check issue
        golangcilint.args = {
            'run',
            '--fix=false',
            '--out-format=json',
            '--show-stats=false',
            '--print-issued-lines=false',
            '--print-linter-name=false',
            "--no-config",
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
        }
        -- Copy from https://github.com/nvimdev/guard-collection/blob/main/lua/guard-collection/linter/golangci_lint.lua
        -- Customized parser to ignore typecheck linter FP and show diangostic.code
        golangcilint.parse = function(result, bufnr)
            local diags = {}

            if result == '' then
                return diags
            end
            result = vim.json.decode(result)

            local issues = result.Issues
            if issues == nil or type(issues) == 'userdata' then
                return diags
            end
            local lint = require('guard.lint')
            local severities = {
                error = lint.severities.ERROR,
                warning = lint.severities.WARN,
                refactor = lint.severities.INFO,
                convention = lint.severities.HINT,
            }

            if type(issues) == 'table' then
                for _, d in ipairs(issues) do
                    -- ignore typecheck linter FP
                    if d.Pos and d.FromLinter ~= 'typecheck' then
                        -- lint.diag_fmt return diagnostic structure, see :help diagnostic structure for more detail
                        local diag = lint.diag_fmt(
                            bufnr,
                            d.Pos.Line > 0 and d.Pos.Line - 1 or 0,
                            d.Pos.Column > 0 and d.Pos.Column - 1 or 0,
                            d.Text,
                            severities[d.Severity] or lint.severities.warning,
                            string.format('golangci-lint: %s', d.FromLinter)
                        )
                        diag.code = d.FromLinter
                        table.insert(diags, diag)
                    end
                end
            end
            return diags
        end
        -- TODO: add trailing space and actionlint linter

        local ft = require('guard.filetype')
        ft('go'):lint('golangci_lint')

        require('guard').setup({
            fmt_on_save = false,
            lsp_as_default_formatter = false,
            save_on_fmt = false,
        })
    end
}
