-- Common documentation snippets
-- Markdown-like markup languages share similar syntaxes, so this snippet file
-- is intended to be included in others.

--# selene: allow(undefined_variable)

local util = require 'plugin.luasnip.util'

local s = util.snippet_with_def_prio()

-- stylua: ignore start
return {
	s({trig = 'heading', dscr = 'Markdown-like section heading with underline'}, fmt([[
		{}
		{}{}

		{}
	]], {
		i(1, 'Title'),
		i(2, '='),
		f(function(args) return string.rep(args[2][1]:sub(1, 1), #args[1][1] - 1) end, { 1, 2 }),
		i(3)
	})),

	s({trig = 'rule', dscr = 'Horizontal rule'}, fmt([[
		{}{}

		{}
	]], {
		i(1, '-'),
		f(function(args) return string.rep(args[1][1]:sub(1, 1), 16) end, 1),
		i(2)
	})),

	s({trig = 'fence', dscr = 'Code fence (```)'}, fmt([[
		```{}
		{}
		```
	]], {
		i(1),
		util.selection(2, 'SELECT_DEDENT'),
	})),

	s({trig = 'link', dscr = 'Inline link, e.g. [Link](https://example.com)'}, fmt([[
		[{}]{}
	]], {
		i(1),
		c(2, {
			sn(nil, fmt('[{}]', { i(1) })),
			sn(nil, fmt('({})', { i(1) })),
		}),
	})),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
