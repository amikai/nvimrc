return {
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "ansiblels",
                "gopls",
                "pyright",
                "golangci_lint_ls",
                "dockerls",
                "terraformls",
                "html",
                "bashls",
                "lua_ls",
                "vimls",
                "yamlls",
                "graphql",
            },
            automatic_installation = true,
        },
        config = function(_, opts)
            require("mason").setup()
            require("mason-lspconfig").setup(opts)
        end,
    },
}
