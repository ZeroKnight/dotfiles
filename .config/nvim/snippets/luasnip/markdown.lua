-- Markdown snippets

--# selene: allow(undefined_variable)

local util = require 'plugin.luasnip.util'

-- stylua: ignore start
return {
	s({trig = 'img', dscr = 'Image'}, fmt('![{}]({}){}', {
		i(1, 'alt text'),
		i(2, 'path'),
		c(3, {
			t '',
			sn(nil, fmt('"{}"', { i(1, 'title') })),
		}),
	})),

	s({trig = 'linkr', dscr = 'Link reference'}, fmt('[{}]: https://{}{}', {
		i(1, '1'),
		i(2, 'example.com'),
		c(3, {
			t '',
			sn(nil, fmt(' "{}"', i(1, 'optional title'))),
		}),
	})),

	s({trig = 'fn', dscr = 'Footnote'}, fmt('[^{}]', { i(1, '1') })),

	s({trig = 'fnr', dscr = 'Footnote reference'}, fmt('[^{}]: {}', { i(1, '1'), i(2) })),

	s({trig = 'table(%d)x(%d)', dscr = 'Create an AxB sized table', regTrig = true}, {
		d(1, function(_, snip)
			local cols = snip.captures[2]
			local header = {
				string.rep('| {} ', cols) .. '|',
				string.rep('|{}', cols) .. '|',
			}
			local nodes = {}
			for x = 1, cols do
				table.insert(nodes, i(x))
			end
			for x = 1, cols do
				table.insert(nodes, f(function(args)
					return string.rep('-', #args[1][1] + 2)
				end, { x }))
			end
			return sn(nil, fmt(table.concat(header, '\n'), nodes))
		end),
		t {'', ''},
		d(2, function(_, snip)
			local rows = snip.captures[1] - 1
			local cols = snip.captures[2]
			local body, nodes = {}, {}
			for x = 1, rows do
				table.insert(body, string.rep('| {} ', cols) .. '|')
				local n_ph = (x - 1) * cols + 1
				for y = n_ph, n_ph + cols - 1 do
					table.insert(nodes, i(y))
				end
			end
			return sn(nil, fmt(table.concat(body, '\n'), nodes))
		end),
	}),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
