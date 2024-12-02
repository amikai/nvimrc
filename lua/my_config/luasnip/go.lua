local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local snips = require("go.snips")

local snippets = {
    ls.s(
        { trig = "scr", name = "scanner", dscr = "scanner read line by line" },
        fmt(
            [[
        {} := bufio.NewScanner({})
        {}.Buffer(make([]byte, 8*1024), 16*1024*1024)
        for {}.Scan() {{
        	line := {}.Bytes() // without newline
        	// Do something
        }}
        if {} := {}.Err(); {} != nil {{
        	return {}
        }}
      ]], {
                ls.i(1, { "scanner" }),
                ls.i(2, { "reader" }),
                rep(1),
                rep(1),
                rep(1),
                ls.i(3, { "err" }),
                rep(1),
                rep(3),
                ls.d(4, snips.make_return_nodes, { 3 }),
            }),
        snips.in_fn
    ),

}
ls.add_snippets("go", snippets)
