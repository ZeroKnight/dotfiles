-- Puthon file handling snippets

--# selene: allow(undefined_variable)

local util = require 'plugin.luasnip.util'

local function open_call(pos)
  return c(1, {
    i(1, 'file'),
    sn(nil, fmt("{}, '{}'", { i(1, 'file'), i(2, 'w') })),
  })
end

-- stylua: ignore start
return {
	s({trig = 'open', dscr = 'open file'}, fmt('open({})', open_call(1))),

	s({trig = 'wopen', dscr = 'with open(...)'}, fmt([[
		with open({}) as {}:
			{}
	]], {
		open_call(1), i(2, 'file'),
		util.selection(3, 'SELECT_DEDENT', 'pass'),
	})),

	s({trig = 'forl', dscr = 'Iterate over lines in file'}, fmt([[
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
