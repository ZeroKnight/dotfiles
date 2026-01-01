-- Python comprehension snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

-- stylua: ignore start
local function make_comp_snippet(trig, dscr, open, close)
	local body = string.format('%s{}%s', open, close)
	return s({trig = trig, dscr = dscr}, fmt(body, {
		c(1, {
			sn(nil, fmt('{} for {} in {}', {
				i(1, 'expr'), i(2, 'name'), i(3, 'iterable')
			})),
			sn(nil, fmt('{} for {} in {} if {}', {
				i(1, 'expr'), i(2, 'name'), i(3, 'iterable'), i(4, 'condition')
			})),
			sn(nil, fmt('{} if {} else {} for {} in {}', {
				i(1, 'expr_t'), i(2, 'condition'), i(3, 'expr_f'), i(4, 'name'), i(5, 'iterable')
			})),
		}),
	}))
end

return {
	make_comp_snippet('lc', 'List comprehension', '[', ']'),
	make_comp_snippet('sc', 'Set comprehension', '{{', '}}'),
	make_comp_snippet('gc', 'Generator expression', '(', ')'),

	s({trig = 'dc', dscr = 'Dictionary comprehension'}, fmt('{{{}}}', {
		c(1, {
			sn(nil, fmt('{}: {} for {}, {} in {}', {
				i(1, 'expr_k'), i(2, 'expr_v'), i(3, 'k'), i(4, 'v'), i(5, 'iterable')
			})),
			sn(nil, fmt('{}: {} for {}, {} in {} if {}', {
				i(1, 'expr_k'), i(2, 'expr_v'), i(3, 'k'), i(4, 'v'), i(5, 'iterable'), i(6, 'condition')
			})),
		}),
	})),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
