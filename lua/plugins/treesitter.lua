return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
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
            require("nvim-treesitter.install").prefer_git = true
            require("nvim-treesitter.configs").setup(opts)
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
        "p00f/nvim-ts-rainbow",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter",
                opts = {
                    rainbow = {
                        enable = true,
                        extended_mode = false,
                        max_file_lines = 1000,
                    },
                },
            },
        },
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
        event = "InsertEnter",
    },
}
