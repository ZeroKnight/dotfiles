-- Puthon file handling snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

local function open_call(pos)
  return c(1, {
    i(1, 'file'),
    sn(nil, fmt("{}, '{}'", { i(1, 'file'), i(2, 'w') })),
  })
end

-- stylua: ignore start
return {
	s({trig = 'open', desc = 'open file'}, fmt('open({})', open_call(1))),

	s({trig = 'wopen', desc = 'with open(...)'}, fmt([[
		with open({}) as {}:
			{}
	]], {
		open_call(1), i(2, 'file'),
		util.selection(3, 'SELECT_DEDENT', 'pass'),
	})),

	s({trig = 'forl', desc = 'Iterate over lines in file'}, fmt([[
		for {} in {}:
			{}
	]], {
		i(1, 'line'), i(2, 'file'),
		util.selection(3, 'SELECT_DEDENT', 'pass'),
	})),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
