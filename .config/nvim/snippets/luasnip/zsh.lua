-- zsh snippets

--# selene: allow(undefined_variable)

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	s({trig = 'e?if', dscr = '(el)if statement', regTrig = true}, fmt([[
		{}if {}{}{} {{
			{}{}
	]], {
		util.if_trigger('^e', 'el'),
		util.sh.compound_choice(1),
		i(2),
		util.sh.close_compound(1),
		util.selection(3, 'SELECT_DEDENT'),
		c(4, {
			util.if_trigger('^i', {'', '}'}),
			sn(nil, fmt([[
				{}else {{
					{}
				}}
			]], { util.nl(), i(1) })),
			sn(nil, fmt([[
				{}elif {}{}{} {{
					{}
				}}
			]], { util.nl(), util.sh.compound_choice(2), i(1), util.sh.close_compound(2), i(3) })),
			sn(nil, fmt([[
				{}elif {}{}{} {{
					{}
				}}
				else {{
					{}
				}}
			]], { util.nl(), util.sh.compound_choice(2), i(1), util.sh.close_compound(2), i(3), i(4) })),
		}),
	})),

	s({trig = 'el', dscr = 'else statement'}, fmt([[
		else {{
			{}
		}}
	]], {
		util.selection(1, 'SELECT_DEDENT'),
	})),

	s({trig = 'e?ifn?s', dscr = 'el(if) (not) set', regTrig = true}, fmt([[
		{}if {} {{
			{}
		}}
	]], {
		util.if_trigger('^e', 'el'),
		c(1, {
			sn(nil, fmt('[ {}-v {} ]', {
				util.if_trigger('ns$', '! '),
				i(1, 'var'),
			})),
			sn(nil, fmt('(( {}${{+{}}} ))', {
				util.if_trigger('ns$', '! '),
				i(1, 'var'),
			})),
		}),
		util.selection(2, 'SELECT_DEDENT'),
	})),

	s({trig = 'for', dscr = 'for loop'}, fmt([[
		for {} ({}) {{
			{}
		}}
	]], {
		i(1, 'name'),
		i(2),
		util.selection(3, 'SELECT_DEDENT'),
	})),

	s({trig = 'wh', dscr = 'while loop'}, fmt([[
		while {}{}{} {{
			{}
		}}
	]], {
		util.sh.compound_choice(1),
		i(2, 'cond'),
		util.sh.close_compound(1),
		util.selection(3, 'SELECT_DEDENT'),
	})),

	s({trig = 'whr', dscr = 'while loop (read)'}, fmt([[
		while {{ {} -r {} }} {{
			{}
		}}
	]], {
		c(1, {
			t 'read',
			sn(nil, fmt('IFS={} read', { i(1) })),
		}),
		i(2, 'line'),
		util.selection(3, 'SELECT_DEDENT'),
	})),

	s({trig = 'until', dscr = 'until loop'}, fmt([[
		until {}{}{} {{
			{}
		}}
	]], {
		c(1, { t '[[ ', t '[ ', t '(' }),
		i(2, 'cond'),
		util.sh.close_compound(1),
		util.selection(3, 'SELECT_DEDENT'),
	})),

	s({trig = 'repeat', dscr = 'repeat statement'}, fmt([[
		repeat (( {} )) {{
			{}
		}}
	]], {
			i(1, 'expr'),
			util.selection(2, 'SELECT_DEDENT'),
	})),

	s({trig = 'case', dscr = 'case statement'}, fmt([[
		case {} {{
			{})
				{}
				;;{}
		}}
	]], { i(1, 'expr'), i(2, 'pattern'), i(3, 'statement'), i(0) })),

}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
