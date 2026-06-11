local pack = require("my_config.pack")
local g = vim.g

g.matchup_matchparen_stopline = 10000
g.matchup_matchparen_enabled = 1
g.matchup_surround_enabled = 1
g.matchup_matchparen_offscreen = { method = "popup" }
g.matchup_transmute_enabled = 1
g.matchup_matchpref = { html = { tagnameonly = 1 } }

pack.add({ pack.gh("andymass/vim-matchup") })
