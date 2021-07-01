local M = {}

local g = vim.g

function M.setup()
    vim.g.matchup_matchparen_enabled = 1
    vim.g.matchup_surround_enabled = 1
    vim.g.matchup_matchparen_offscreen = { method = 'popup'}
    vim.g.matchup_transmute_enabled = 1
    vim.g.matchup_matchpref = { html = { tagnameonly = 1 }}
end

return M
