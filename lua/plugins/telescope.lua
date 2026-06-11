local pack = require("my_config.pack")
local gh = pack.gh
local km = require("my_config.utils").km_factory({ silent = true })

-- Build hook (:h vim.pack-events)
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
            vim.system({ "make" }, { cwd = ev.data.path }):wait()
        end
    end,
})

pack.add({
    gh("nvim-telescope/telescope-fzf-native.nvim"),
    gh("nvim-telescope/telescope.nvim"),
})

require("telescope").setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "vendor",
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
    },
})
-- libfzf can be missing if the install was interrupted before the PackChanged
-- build hook ran (vim.pack treats the plugin as installed afterwards, so the
-- hook never re-fires). Build it and retry.
local ok = pcall(require("telescope").load_extension, "fzf")
if not ok then
    for _, p in ipairs(vim.pack.get({ "telescope-fzf-native.nvim" })) do
        vim.system({ "make" }, { cwd = p.path }):wait()
    end
    require("telescope").load_extension("fzf")
end

km("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
km("n", "<leader>lg", "<cmd>Telescope live_grep<cr>")
