-- Python snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	s({trig = 'imp?', dscr = 'import foo.bar (as baz)', regTrig = true}, fmt('import {}', {
		c(1, {
			i(1, 'sys'),
			sn(nil, fmt('{} as {}', { i(1, 'sys'), i(2) })),
		}),
	})),

	s({trig = 'fimp?', dscr = 'from foo import bar (as baz)', regTrig = true}, fmt('from {} import {}', {
		i(1, 'sys'),
		c(2, {
			i(1),
			sn(nil, fmt('{} as {}', { i(1), i(2) })),
		}),
	})),

	s({trig = 'e?if', dscr = '(el)if statement', regTrig = true}, fmt([[
		{}if {}:
			{}{}
	]], {
		util.if_trigger('^e', 'el'),
		i(1),
		util.selection(2, 'SELECT_DEDENT', 'pass'),
		c(3, {
			t '',
			sn(nil, fmt([[
				{}else:
					{}
			]], { util.nl(), i(1, 'pass') })),
			sn(nil, fmt([[
				{}elif {}:
					{}
			]], { util.nl(), i(1), i(2, 'pass') })),
			sn(nil, fmt([[
				{}elif {}:
					{}
				else:
					{}
			]], { util.nl(), i(1), i(2, 'pass'), i(3, 'pass') })),
		}),
	})),

	s({trig = 'el', dscr = 'else statement'}, fmt([[
		else:
			{}
	]], {
		util.selection(1, 'SELECT_DEDENT', 'pass')
	})),

	s({trig = 'e?ifnn?', dscr = '(el)if x is (not) None', regTrig = true}, fmt([[
		{}if {} is{} None:
			{}
	]], {
		util.if_trigger('^e', 'el'),
		i(1, 'x'),
		util.if_trigger('nn$', ' not'),
		util.selection(2, 'SELECT_DEDENT', 'pass')
	})),

	s({trig = 'for', dscr = 'for loop'}, fmt([[
		for {}:
			{}
	]], {
		c(1, {
			sn(nil, fmt('{} in {}', { i(1, 'x'), i(2, 'y') })),
			sn(nil, fmt('{} in range({})', { i(1, 'i'), i(2, '10') })),
			sn(nil, fmt('{}, {} in {}.items()', { i(1, 'k'), i(2, 'v'), i(3, 'd') })),
		}),
		util.selection(2, 'SELECT_DEDENT', 'pass'),
	})),

	s({trig = 'wh', dscr = 'while loop'}, fmt([[
		while {}:
			{}
	]], {
		i(1),
		util.selection(2, 'SELECT_DEDENT', 'pass'),
	})),

	s({trig = 'try', dscr = 'try ... except'}, fmt([[
		try:
			{}
		except {}:
			{}
	]], {
		util.selection(1, 'SELECT_DEDENT', 'pass'),
		c(2, {
			i(1, 'Exception'),
			sn(nil, {
				i(1, 'Exception'),
				n(2, ' as '),
				i(2, 'exc'),
			}),
		}),
		i(3, 'pass'),
	})),

	s({trig = 'exc', dscr = 'except Exception (as exc) ...'}, fmt([[
		except {}:
			{}
	]], {
		c(1, {
			i(1, 'Exception'),
			sn(nil, {
				i(1, 'Exception'),
				n(2, ' as '),
				i(2, 'exc'),
			}),
		}),
		util.selection(2, 'SELECT_DEDENT', 'pass'),
	})),

	s({trig = 'fin', dscr = 'finally block'}, fmt([[
		finally:
			{}
	]], {
		util.selection(1, 'SELECT_DEDENT', 'pass'),
	})),

	s({trig = 'r', dscr = 'raise staement'}, fmt('raise {}{}', {
		c(1, {
			t 'TypeError',
			t 'ValueError',
			t 'KeyError',
		}),
		c(2, {
			t '',
			sn(nil, fmt(' from {}', { i(1, 'None') }, { dedent = false })),
		}),
	})),

	s({trig = 'with', dscr = 'with statement'}, fmt([[
		with {} as {}:
			{}
	]], {
		i(1, 'expr'),
		i(2, 'x'),
		util.selection(3, 'SELECT_DEDENT', 'pass'),
	})),

	s({trig = 'a?def[mcs]?', dscr = 'Function/method definition', regTrig = true}, fmt([[
		{deco}{async}def {name}({self}{args}){ret_anno}:
			"""{docstring}{close_doc}
			{fn_body}
	]], {
		deco = util.when_trigger { ['c$'] = { '@classmethod', '' }, ['s$'] = { '@staticmethod', '' } },
		async = util.if_trigger('^a', 'async '),
		name = i(1, 'foo'),
		self = util.when_trigger { ['c$'] = 'cls, ', ['m$'] = 'self, ' },
		args = i(2),
		ret_anno = c(3, {
			sn(nil, fmt(' -> {}', { i(1, 'None') }, { dedent = false })),
			t '',
		}),
		docstring = util.python.docstring_summary(4, 1),
		close_doc = util.python.close_docstring(4),
		fn_body = util.selection(5, 'SELECT_DEDENT', 'pass'),
	})),
}, { -- Autosnippets
	s({trig = '#!', dscr = 'shebang'}, fmt([[
		#!/usr/bin/env python{}

		{}
	]], {
		i(1, '3'), i(0)
	})),
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
