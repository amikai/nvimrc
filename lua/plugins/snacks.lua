local pack = require("my_config.pack")
local km = require("my_config.utils").km_factory({ silent = true })

pack.add({ pack.gh("folke/snacks.nvim") })

require("snacks").setup({
    -- LSP-based highlight of the word under cursor (replaces vim-illuminate)
    words = { enabled = true },
    -- Indent guides (replaces indent-blankline.nvim)
    indent = {
        enabled = true,
        animate = { enabled = false },
        indent = { char = "▏" },
        scope = { char = "▏" },
    },
    -- Fold/sign/number/git gutter (replaces statuscol.nvim)
    statuscolumn = {
        enabled = true,
        folds = { open = true },
    },
    zen = {
        toggles = { dim = false },
    },
    styles = {
        zen = { width = 100 },
    },
})

-- vim-sayonara replacements: <leader>c keeps the window (Sayonara!),
-- <leader>q closes it too (Sayonara).
km("n", "<leader>c", function()
    Snacks.bufdelete()
end)
km("n", "<leader>q", function()
    Snacks.bufdelete()
    vim.cmd.quit()
end)

-- toggleterm replacement
km({ "n", "t" }, "<F1>", function()
    Snacks.terminal.toggle()
end)

-- zen-mode/twilight replacements
km("n", "<F2>", function()
    Snacks.zen()
end)
Snacks.toggle.dim():map("<F50>")

-- Show indent guides only while inserting, as the old indent-blankline
-- autocommands did.
local gid = vim.api.nvim_create_augroup("my_config_snacks_indent", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
    group = gid,
    callback = function()
        Snacks.indent.enable()
    end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    group = gid,
    callback = function()
        Snacks.indent.disable()
    end,
})

-- Snacks.words highlights through the standard LSP reference groups; port the
-- old IlluminatedWord* colors for iceberg.
local function set_reference_hl()
    for _, group in ipairs({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }) do
        vim.api.nvim_set_hl(0, group, {
            ctermfg = 251,
            ctermbg = 236,
            fg = "#c6c8d1",
            bg = "#3d425b",
        })
    end
end
set_reference_hl()
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "iceberg",
    callback = set_reference_hl,
})
