-- Miscellaneous Python idioms and shortcuts

--# selene: allow(undefined_variable)

local util = require 'plugin.luasnip.util'

-- stylua: ignore start
return {
	s({trig = 'main', dscr = "if __name__ == '__main__'"}, fmt([[
		if __name__ == '__main__':
			{}
	]], { util.selection(1, 'SELECT_DEDENT', 'pass') })),

	s({trig = 'rni', dscr = 'raise NotImplementedError'}, {
		t 'raise NotImplementedError'
	}),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
