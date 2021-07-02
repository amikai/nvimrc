local M = {}

local g = vim.g

function M.setup()
    g.matchup_matchparen_enabled = 1
    g.matchup_surround_enabled = 1
    g.matchup_matchparen_offscreen = { method = 'popup'}
    g.matchup_transmute_enabled = 1
    g.matchup_matchpref = { html = { tagnameonly = 1 }}
end

return M
