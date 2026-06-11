local pack = require("my_config.pack")
local gh = pack.gh

-- go.nvim and friends are loaded on demand for Go files.
pack.register({
    gh("ray-x/guihua.lua"),
    gh("ray-x/go.nvim"),
    gh("folke/trouble.nvim"),
    -- for debugging
    gh("mfussenegger/nvim-dap"),
    gh("rcarriga/nvim-dap-ui"),
    gh("theHamsta/nvim-dap-virtual-text"),
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("my_config_go", { clear = true }),
    pattern = { "go", "gomod" },
    once = true,
    callback = function(args)
        pack.load({
            "guihua.lua",
            "trouble.nvim",
            "nvim-dap",
            "nvim-dap-ui",
            "nvim-dap-virtual-text",
            "go.nvim",
        })

        require("go").setup({
            lsp_cfg = false,
            lsp_codelens = false,
            lsp_gofumpt = true,
            lsp_keymaps = false,
            diagnostic = {
                underline = true,
                virtual_text = true,
                sign = true,
                float = {
                    format = function(diagnostic)
                        return diagnostic.message
                    end,
                    suffix = function(diagnostic)
                        return string.format(" [%s]", diagnostic.source), ""
                    end,
                },
            },
            luasnip = true,
            gopls_cmd = { require("mason.settings").current.install_root_dir .. "/bin/gopls" },
            lsp_inlay_hints = {
                enable = false,
            },
            trouble = false,
        })
        vim.lsp.config.gopls = require("go.lsp").config()
        vim.lsp.enable("gopls")

        -- Re-run FileType autocommands so go.nvim's ftplugin and the LSP
        -- attach to the buffer that triggered the load.
        vim.api.nvim_exec_autocmds("FileType", { buffer = args.buf })
    end,
})
