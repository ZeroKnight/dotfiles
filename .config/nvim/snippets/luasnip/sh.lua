-- sh snippets
-- Snippets common to any shell as well as POSIX-compliant idioms

--# selene: allow(undefined_variable)

local util = require 'plugins.snippet.util'

local s = util.snippet_with_def_prio()

-- stylua: ignore start
return {
	s({trig = 'scriptdir', dscr = 'Directory of the script'}, fmt('{}={}', {
		i(1, 'dir'),
		c(2, {
			t '$(dirname "$(realpath -P -- "$0")")',
			t '$(dirname "$(readlink -f -- "$0")")',
			t '$(cd -- "$(dirname -- "$0")" && pwd -P)',
		}),
	})),

	s({trig = 'e?if', dscr = '(el)if statement', regTrig = true}, fmt([[
		{}if {}{}{}; then
			{}{}
	]], {
		util.if_trigger('^e', 'el'),
		util.sh.compound_choice(1),
		i(2),
		util.sh.close_compound(1),
		util.selection(3, 'SELECT_DEDENT'),
		c(4, {
			util.if_trigger('^i', {'', 'fi'}),
			sn(nil, fmt([[
				{}else
					{}
				fi
			]], { util.nl(), i(1) })),
			sn(nil, fmt([[
				{}elif {}{}{}
					{}
				fi
			]], { util.nl(), util.sh.compound_choice(2), i(1), util.sh.close_compound(2), i(3) })),
			sn(nil, fmt([[
				{}elif {}{}{}
					{}
				else
					{}
				fi
			]], { util.nl(), util.sh.compound_choice(2), i(1), util.sh.close_compound(2), i(3), i(4) })),
		}),
	})),

	s({trig = 'el', dscr = 'else statement'}, fmt([[
		else
			{}
	]], {
		util.selection(1, 'SELECT_DEDENT'),
	})),

	s({trig = 'e?ifn?s', dscr = 'el(if) (not) set', regTrig = true}, fmt([[
		{}if [ {}"${{{}+x}}" ]; then
			{}{}
	]], {
		util.if_trigger('^e', 'el'),
		util.if_trigger('ns$', '-z '),
		i(1, 'var'),
		util.selection(2, 'SELECT_DEDENT'),
		util.if_trigger('^i', {'', 'fi'}),
	})),

	s({trig = 'for', dscr = 'for loop'}, fmt([[
		for {}; do
			{}
		done
	]], {
		c(1, {
			sn(nil, fmt('{}{}', {
				i(1, 'name'),
				c(2, {
					sn(nil, fmt(' in {}', { i(1) }, { dedent = false })),
					t '',
				}),
			})),
			sn(nil, fmt('(( {}; {}; {} ))', {
				i(1, 'init'),
				i(2, 'cond'),
				i(3, 'post'),
			})),
		}),
		util.selection(2, 'SELECT_DEDENT'),
	})),

	s({trig = 'wh', dscr = 'while loop'}, fmt([[
		while {}{}{}; do
			{}
		done
	]], {
		util.sh.compound_choice(1),
		i(2, 'cond'),
		util.sh.close_compound(1),
		util.selection(3, 'SELECT_DEDENT'),
	})),

	s({trig = 'whr', dscr = 'while loop (read)'}, fmt([[
		while {} -r {}; do
			{}
		done
	]], {
		c(1, {
			t 'read',
			sn(nil, fmt('IFS={} read', { i(1) })),
		}),
		i(2, 'line'),
		util.selection(3, 'SELECT_DEDENT'),
	})),

	s({trig = 'until', dscr = 'until loop'}, fmt([[
		until {}{}{}; do
			{}
		done
	]], {
		c(1, { t '[[ ', t '[ ', t '(' }),
		i(2, 'cond'),
		util.sh.close_compound(1),
		util.selection(3, 'SELECT_DEDENT'),
	})),

	s({trig = 'case', dscr = 'case statement'}, fmt([[
		case {} in
			{})
				{}
				;;{}
		esac
	]], { i(1, 'expr'), i(2, 'pattern'), i(3, 'statement'), i(0) })),

	s({trig = 'casep', dscr = 'case pattern'}, fmt([[
		{})
			{}
			;;{}
	]], { i(1, 'pattern'), i(2, 'statement'), i(0) })),

	s({trig = 'sel', dscr = 'select statement'}, fmt([[
		select {}{}; do
			{}
		done
	]], {
		i(1, 'name'),
		c(2, {
			sn(nil, fmt(' in {}', { i(1) }, { dedent = false })),
			t '',
		}),
		util.selection(3, 'SELECT_DEDENT'),
	})),

	s({trig = 'here', dscr = 'Here Document'}, fmt([[
		{}
		{}
		{}
	]], {
		c(1, {
			sn(nil, fmt('<<{}', { i(1, 'EOF') })),
			sn(nil, fmt('<<-{}', { i(1, 'EOF') })),
			sn(nil, fmt('{}<<{}', { i(2, '2'), i(1, 'EOF') })),
			sn(nil, fmt('{}<<-{}', { i(2, '2'), i(1, 'EOF') })),
		}),
		i(2),
		l(l._1:gsub('%d*<<%-?', ''), 1),
	})),

	s({trig = 'heres', dscr = 'Here String'}, fmt('{} {}', {
		c(1, {
			t '<<<',
			sn(nil, fmt('{}<<<', { i(1, '2') })),
		}),
		i(2),
	})),

}, { -- Autosnippets
	s({trig = '#!', dscr = 'shebang'}, fmt([[
		#!{}{}

		{}
	]], {
		c(1, {
			t '/usr/bin/env ',
			t '/usr/bin/',
			t '/bin/',
		}),
		c(2, {
			f(function() return vim.bo.filetype end),
			t 'sh',
		}),
		i(0),
	})),
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
