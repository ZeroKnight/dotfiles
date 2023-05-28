-- C snippets

--# selene: allow(undefined_variable)

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	s({trig = 'e?if', dscr = '(else) if statement', regTrig = true}, fmt([[
		{}if ({}) {{
			{}{}
	]], {
		util.if_trigger('^e', 'else '),
		i(1),
		util.selection(2, 'SELECT_DEDENT'),
		c(3, {
			util.if_trigger('^i', {'', '}'}),
			sn(nil, fmt([[
				{}else {{
					{}
				}}
			]], { util.nl(), i(1) })),
			sn(nil, fmt([[
				{}else if ({}) {{
					{}
				}}
			]], { util.nl(), i(1), i(2) })),
			sn(nil, fmt([[
				{}else if ({}) {{
					{}
				}}
				else {{
					{}
				}}
			]], { util.nl(), i(1), i(2), i(3) })),
		}),
	})),

	s({trig = 'el', dscr = 'else statement'}, fmt([[
		else {{
			{}
		}}
	]], { util.selection(1, 'SELECT_DEDENT') })),

	s({trig = 'for', dscr = 'for loop'}, fmt([[
		for ({}; {}; {}) {{
			{}
		}}
	]], {
		i(1), i(2), i(3),
		util.selection(4, 'SELECT_DEDENT'),
	})),

	s({trig = 'fori', dscr = 'for loop (range)'}, fmt([[
		for ({}) {{
			{}
		}}
	]], {
		c(1, {
			sn(nil, fmt('size_t {} = {}; {} < {}; ++{}', {
				i(1, 'i'), i(2, '0'),
				rep(1), i(3),
				rep(1),
			})),
			sn(nil, fmt('size_t {} = {}; {} > {}; --{}', {
				i(1, 'i'), i(2),
				rep(1), i(3, '0'),
				rep(1),
			})),
		}),
		util.selection(2, 'SELECT_DEDENT'),
	})),

	s({trig = 'wh', dscr = 'while loop'}, fmt([[
		while ({}) {{
			{}
		}}
	]], { i(1), util.selection(2, 'SELECT_DEDENT'), })),

	s({trig = 'dw', dscr = 'do while loop'}, fmt([[
		do {{
			{}
		}} while ({});
	]], { util.selection(2, 'SELECT_DEDENT'), i(1), })),

	s({trig = 'sw', dscr = 'switch statement'}, fmt([[
		switch ({}) {{
			case {}:
				{}
				break;
		}}
	]], { i(1), i(2), i(0) })),

	s({trig = 'cased?', dscr = 'case statement', regTrig = true}, fmt([[
		{} {}:
			{}
			break;
	]], { util.if_trigger('d$', 'default', 'case'), i(1), i(2) })),

	s({trig = 't?enum', dscr = 'enum definition', regTrig = true}, fmt([[
		{}enum {} {{
			{}
		}}{};
	]], {
		util.if_trigger('^t', 'typedef '),
		i(1), i(3),
		d(2, function(args, snip)
			if snip.trigger:match('^t') then
				return sn(nil, fmt(' {}_t', i(1, args[1][1]), { dedent = false }))
			end
			return sn(nil, t '')
		end, 1),
	})),

	s({trig = 't?struct', dscr = 'struct definition', regTrig = true}, fmt([[
		{}struct {} {{
			{}
		}}{};
	]], {
		util.if_trigger('^t', 'typedef '),
		i(1), i(3),
		d(2, function(args, snip)
			if snip.trigger:match('^t') then
				return sn(nil, fmt(' {}_t', i(1, args[1][1]), { dedent = false }))
			end
			return sn(nil, t '')
		end, 1),
	})),

	s({trig = 't?union', dscr = 'union definition', regTrig = true}, fmt([[
		{}union {} {{
			{}
		}}{};
	]], {
		util.if_trigger('^t', 'typedef '),
		i(1), i(3),
		d(2, function(args, snip)
			if snip.trigger:match('^t') then
				return sn(nil, fmt(' {}_t', i(1, args[1][1]), { dedent = false }))
			end
			return sn(nil, t '')
		end, 1),
	})),

	s({trig = 'td', dscr = 'typedef'}, fmt('typedef {} {};', { i(1, 'int'), i(2, 'name') })),

	s({trig = 'fn', dscr = 'function definition'}, fmt([[
		{} {}({}) {{
			{}
		}}
	]], { i(1, 'void'), i(2, 'name'), i(3), i(4) })),

	s({trig = 'fnd', dscr = 'function declaration'}, fmt([[
		{} {}({});
	]], { i(1, 'void'), i(2, 'name'), i(3) })),

}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
