return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        opts = {
            ensure_installed = {
                "c",
                "rust",
                "cpp",
                "make",
                "cmake",
                "bash",
                "go",
                "gomod",
                "gowork",
                "html",
                "javascript",
                "css",
                "scss",
                "yaml",
                "json",
                "toml",
                "dockerfile",
                "python",
                "vim",
                "lua",
                "proto",
                "graphql",
                "typescript",
                "hurl",
                "vimdoc",
                "comment",
                "git_config",
                "gitignore",
                "gosum",
                "gotmpl",
                "hcl",
                "markdown",
                "markdown_inline",
                "regex",
                "sql",
                "terraform",
                "tsx",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                disable = { "python" },
            },
            -- Indentation based on treesitter for the = operator
            indent = {
                enable = true,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter").install(opts.ensure_installed)

            vim.treesitter.language.register("yaml", "yaml.github")
            vim.treesitter.language.register("yaml", "yaml.gitlab")

            local disabled = {}
            for _, ft in ipairs(opts.highlight.disable or {}) do
                disabled[ft] = true
            end

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    if ft == "" or disabled[ft] then
                        return
                    end
                    pcall(vim.treesitter.start, args.buf)
                    if opts.indent and opts.indent.enable then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("treesitter-context").setup({
                enable = true,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter",
                opts = {
                    textobjects = {
                        select = {
                            enable = true,
                            lookahead = true,
                            keymaps = {
                                ["af"] = "@function.outer",
                                ["if"] = "@function.inner",
                                ["i,"] = "@parameter.inner",
                                ["a,"] = "@parameter.outer",
                                ["ac"] = "@comment.outer",
                            },
                            include_surrounding_whitespace = true,
                        },
                        swap = {
                            enable = true,
                            swap_next = {
                                ["g>"] = "@parameter.inner",
                            },
                            swap_previous = {
                                ["g<"] = "@parameter.inner",
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require('rainbow-delimiters.setup').setup {}
        end
    },
    {
        "RRethy/nvim-treesitter-endwise",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter",
                opts = {
                    endwise = {
                        enable = true,
                    },
                },
            },
        },
        event = "InsertEnter"
    }
}
