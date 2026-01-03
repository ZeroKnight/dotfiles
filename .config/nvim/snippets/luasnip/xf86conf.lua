-- xf86conf snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	s({trig = 'sec', desc = 'Section ... EndSection'}, fmt([[
		Section "{}"
			{}
		EndSection
	]], { i(1), i(2) })),

	s({trig = 'opt', desc = "Option 'foo' 'bar'"}, fmt([[
		Option "{}" "{}"
	]], { i(1), i(2) })),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
