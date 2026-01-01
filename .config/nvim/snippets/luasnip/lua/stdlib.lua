-- Lua stdlib snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	-- Basic functions

	s({trig = 'err', dscr = 'error()'}, fmt('error({}{})', {
		i(1),
		c(2, {
			sn(nil, fmt(', {}', { i(1, '2') })),
			t '',
		}),
	})),

	s({trig = 'pcall', dscr = 'Protected function call'}, fmt('local {}, {} = pcall({})', {
		i(1, 'ok'), i(2, 'err'), i(3)
	})),

	-- string

	s({trig = 'fmt', dscr = 'string.format'}, fmt('string.format({}, {})', {
		c(1, {
			sn(nil, fmt("'{}'", i(1))),
			sn(nil, fmt('[[{}]]', i(1))),
			t ''
		}),
		d(2, util.generate_insertnodes '%%[cdefgioqsuxEGX]', 1),
	})),

	-- table

	s({trig = 'concat', dscr = 'table.concat'}, fmt('table.concat({}, {})', { i(1, 't'), i(2) })),
	s({trig = 'ins', dscr = 'table.insert'}, fmt('table.insert({}, {})', { i(1, 't'), i(2), })),
	s({trig = 'sort', dscr = 'table.sort'}, fmt('table.sort({})', { i(1, 't') })),

	-- IO

	s({trig = 'open', dscr = 'io.open'}, fmt("io.open({}, '{}')", {
		i(1, 'filename'),
		i(2, 'r'),
	})),

	s({trig = 'popen', dscr = 'io.popen'}, fmt("io.popen({}, '{}')", {
		i(1, 'prog'),
		i(2, 'r'),
	})),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
