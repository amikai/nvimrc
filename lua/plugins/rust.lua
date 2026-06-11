local pack = require("my_config.pack")
local gh = pack.gh

vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
        enable_nextest = true,
        enable_clippy = true,
        reload_workspace_from_cargo_toml = true,
    },
    -- LSP configuration
    server = {
        -- disable loading vscode settings
        load_vscode_settings = 0,
        cmd = function()
            -- NOTE: copy from https://github.com/mrcjkb/rustaceanvim/blob/master/doc/mason.txt
            -- use mason to manage the installation of rust-analyzer
            local mason_registry = require("mason-registry")
            -- trim trial newline
            local ra_from_rustup = string.gsub(vim.fn.system("rustup which rust-analyzer"), "%s+", "")
            -- try to use rust-analyzer from rustup first, then from
            -- mason, finally from $PATH
            local ra_binary = (vim.fn.executable("rustup") == 1 and ra_from_rustup)
                or (mason_registry.is_installed("rust-analyzer")
                    -- This may need to be tweaked, depending on the operating system.
                    and require("mason.settings").current.install_root_dir .. "/bin/rust-analyzer"
                ) or "rust-analyzer"
            return { ra_binary } -- You can add args to the list, such as '--log-file'
        end,
        settings = {
            -- See https://rust-analyzer.github.io/manual.html
            ["rust-analyzer"] = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "crate",
                },
                checkOnSave = true,
            },
        },
    },
    -- DAP configuration
    dap = {
    },
}

pack.add({
    { src = gh("mrcjkb/rustaceanvim"), version = vim.version.range("^6.0.0") },
})

-- crates.nvim is loaded on demand when a Cargo.toml is opened.
pack.register({ gh("saecki/crates.nvim") })

vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("my_config_crates", { clear = true }),
    pattern = "Cargo.toml",
    once = true,
    callback = function()
        pack.load({ "crates.nvim" })
        require("crates").setup({
            popup = {
                autofocus = true,
            },
            completion = {
                crates = {
                    enabled = true,
                },
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        })
    end,
})
