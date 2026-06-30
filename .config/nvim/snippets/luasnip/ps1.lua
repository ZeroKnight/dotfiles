-- PowerShell snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	s({trig = 'for', desc = 'foreach loop'}, fmt([[
		foreach (${} in ${}) {{
			{}
		}}
	]], {
		i(1, 'x'),
		i(2, 'y'),
		util.selection(2, 'SELECT_DEDENT'),
	})),

	s({trig = 'fori', desc = 'for loop (range)'}, fmt([[
		for ({}) {{
			{}
		}}
	]], {
		c(1, {
			sn(nil, fmt('${} = {}; ${} -lt ${}; ++${}', {
				i(1, 'i'), i(2, '0'),
				rep(1), i(3, 'x'),
				rep(1),
			})),
			sn(nil, fmt('${} = {}; ${} -gt {}; --${}', {
				i(1, 'i'), i(2),
				rep(1), i(3, '0'),
				rep(1),
			})),
			sn(nil, fmt('{}; {}; {}', { i(1), i(2), i(3) })),
		}),
		util.selection(2, 'SELECT_DEDENT'),
	})),

	s({trig = 'wh', desc = 'while loop'}, fmt([[
		while ({}) {{
			{}
		}}
	]], {
		i(1, '$true'),
		util.selection(2, 'SELECT_DEDENT'),
	})),

	s({trig = 'dw', desc = 'do while loop'}, fmt([[
		do {{
			{}
		}} while ({})
	]], {
		i(1, '$true'),
		util.selection(2, 'SELECT_DEDENT'),
	})),

	s({trig = 'until', desc = 'do until loop'}, fmt([[
		do {{
			{}
		}} until ({})
	]], {
		i(1, '$true'),
		util.selection(2, 'SELECT_DEDENT'),
	})),

	s({trig = 'e?if', desc = '(else)if statement', regTrig = true}, fmt([[
		{}if ({}) {{
			{}{}
	]], {
		util.if_trigger('^e', 'else'),
		i(1),
		util.selection(2, 'SELECT_DEDENT'),
		c(3, {
			t { '', '}' },
			sn(nil, fmt([[
				{}else {{
					{}
				}}
			]], { util.nl(), i(1) })),
			sn(nil, fmt([[
				{}elseif ({}) {{
					{}
				}}
			]], { util.nl(), i(1), i(2) })),
			sn(nil, fmt([[
				{}elseif ({}) {{
					{}
				}}
				else {{
					{}
				}}
			]], { util.nl(), i(1), i(2), i(3) })),
		}),
	})),

	s({trig = 'e?ifnn?', desc = '(else)if x is (not) null', regTrig = true}, fmt([[
		{}if ($null {} ${}) {{
			{}
		}}
	]], {
		util.if_trigger('^e', 'else'),
		util.if_trigger('nn$', '-ne', '-eq'),
		i(1, 'x'),
		util.selection(2, 'SELECT_DEDENT'),
	})),

	s({trig = 'el', desc = 'else statement'}, fmt([[
		else {{
			{}
		}}
	]], {
		util.selection(1, 'SELECT_DEDENT'),
	})),

	s({trig = 'should', desc = 'if $PSCmdlet.ShouldProcess'}, fmt([[
		if ($PSCmdlet.ShouldProcess(${}, ${})) {{
			{}
		}}
	]], {
		i(1, 'Target'), i(2, 'Operation'),
		util.selection(3, 'SELECT_DEDENT'),
	})),

	s({trig = 'sw[ewr]?', desc = 'switch statement', regTrig = true}, fmt([[
		switch {}(${}) {{
			{}
		}}
	]], {
		util.when_trigger { ['e$'] = '-Exact ', ['ww$'] = '-Wildcard ', ['r$'] = '-Regex ' },
		i(1, 'x'),
		c(2, {
			sn(nil, fmta('<> { <> }<>', {
				r(1, 'case_pat', i(1, 'value')),
				r(2, 'case_body', util.selection(2, 'SELECT_DEDENT')),
				i(0),
			})),
			isn(nil, fmta([[
				<> { <> }
				default { <> }
			]], {
				r(1, 'case_pat', i(1, 'value')),
				r(2, 'case_body', util.selection(2, 'SELECT_DEDENT')),
				i(3),
			}), '$PARENT_INDENT\t'),
		}),
	})),

	s({trig = 'cased?', desc = 'case statement', regTrig = true}, fmta('<> { <> }', {
		util.if_trigger('d$', 'default', 'value'),
		util.selection(1, 'SELECT_DEDENT'),
	})),

	s({trig = 'enum', desc = 'enumeration definition'}, fmt([[
		enum {} {{
			{}
		}}
	]], { i(1, 'Name'), i(2, 'Label') })),

	s({trig = 'try', desc = 'try/catch statemetn'}, fmt([[
		try {{
			{}
		}}
		{}
	]], {
		util.selection(1, 'SELECT_DEDENT'),
		c(2, {
			sn(nil, fmt([[
				catch {{
					{}
				}}
			]], { i(1) })),
			sn(nil, fmt([[
				catch [{}] {{
					{}
				}}
			]], { i(1), i(2) })),
		}),
	})),

	s({trig = 'catch', desc = 'catch statement'}, {
		c(1, {
			sn(nil, fmt([[
				catch {{
					{}
				}}
			]], { r(1, 'body', util.selection(1, 'SELECT_DEDENT')) })),
			sn(nil, fmt([[
				catch [{}] {{
					{}
				}}
			]], { i(1), r(2, 'body', util.selection(1, 'SELECT_DEDENT')) })),
		}),
	}),

	s({trig = 'fin', desc = 'finally statement'}, fmt([[
		finally {{
			{}
		}}
	]], { util.selection(1, 'SELECT_DEDENT') })),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
