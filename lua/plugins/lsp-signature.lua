local pack = require("my_config.pack")

pack.add({ pack.gh("ray-x/lsp_signature.nvim") })

require("lsp_signature").setup({
    bind = true,
    -- Auto-popup the signature window whenever the cursor is inside the
    -- argument list, and keep the current parameter as virtual-text hint.
    floating_window = true,
    hint_enable = true,
    handler_opts = { border = "rounded" },
    -- Re-show a dismissed signature window.
    toggle_key = "<M-s>",
})
