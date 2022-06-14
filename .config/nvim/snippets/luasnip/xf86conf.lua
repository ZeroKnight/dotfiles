-- xf86conf snippets

--# selene: allow(undefined_variable)

local util = require 'plugin.luasnip.util'

-- stylua: ignore start
return {
	s({trig = 'sec', dscr = 'Section ... EndSection'}, fmt([[
		Section "{}"
			{}
		EndSection
	]], { i(1), i(2) })),

	s({trig = 'opt', dscr = "Option 'foo' 'bar'"}, fmt([[
		Option "{}" "{}"
	]], { i(1), i(2) })),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
