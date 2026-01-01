-- Global snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	s({trig = 'sig', dscr = 'Signature'}, f(util.author)),

	s({trig = 'todo', dscr = 'Create a TODO comment'}, fmt('{} {}: {}', {
		f(util.get_comment),
		c(1, { t 'TODO', t 'TBD', t 'FIXME', t 'NOTE', t 'IDEA', t 'WARN', t 'HACK', t 'PERF' }),
		i(2),
	})),

	s({trig = 'copyright', dscr = 'Copyright string'}, fmt('Copyright © {} {}', {
		p(os.date, '%Y'),
		f(util.author),
	})),

	s({trig = 'time', dscr = 'Current time'},
		c(1, {
			p(os.date, '%T'), -- ISO 8601
			p(os.date, '%k:%M:%S'), -- 24h, no zero-padding
			p(os.date, '%H:%M:%S.%f'), -- ISO 8601 with microseconds
			p(os.date, '%H:%M:%S%z'), -- ISO 8601 with timezone
			p(os.date, '%k:%M:%S%z'), -- 24h, no zero-padding with timezone
			p(os.date, '%I:%M:%S %p'), -- 12h
			p(os.date, '%l:%M:%S %p'), -- 12h, no zero-padding
			p(os.date, '%I:%M:%S%z %p'), -- 12h with timezone
			p(os.date, '%l:%M:%S%z %p'), -- 12h, no zero-padding with timezone
			p(os.date, '%s'), -- UNIX Timestamp
			p(os.date, '%X'), -- Current locale time format
		})
	),

	s({trig = 'date', dscr = 'Current date'},
		c(1, {
			p(os.date, '%F'), -- ISO 8601
			p(os.date, '%m/%d/%Y'), -- US Format
			p(os.date, '%d/%m/%Y'), -- Non-US Format
			p(os.date, '%b %d, %y'), -- Short month name
			p(os.date, '%a %b %d, %y'), -- Short month with short weekday
			p(os.date, '%A %b %d, %y'), -- Short month with full weekday
			p(os.date, '%B %d, %y'), -- Full month name
			p(os.date, '%a %B %d, %y'), -- Full month with short weekday
			p(os.date, '%A %B %d, %y'), -- Full month with full weekday
			p(os.date, '%x') -- Current locale date format
		})
	),

	s({trig = 'datetime', dscr = 'Current date/time'},
		c(1, {
			p(os.date, '%F %T'), -- ISO 8601
			p(os.date, '%B %d, %Y %T'), -- Full month, 24h
			p(os.date, '%A %B %d, %Y %T'), -- Full month, full weekday, 24h
			p(os.date, '%B %d, %Y %r'), -- Full month, 12h
			p(os.date, '%A %B %d, %Y %r'), -- Full month, full weekday, 12h
			p(os.date, '%c') -- Current locale datetime format
		})
	),

	-- Folding Snippets

	s({trig = 'fold', dscr = 'Vim opening fold marker'}, fmt('{} {} {}{}', {
		f(util.get_comment),
		i(1, 'Fold description'),
		p(util.get_foldmarker, 'open'),
		i(2, '1'),
	})),

	s({trig = 'foldc', dscr = 'Vim closing fold marker'}, fmt('{} {}{}', {
		f(util.get_comment),
		p(util.get_foldmarker, 'close'),
		i(1, '1'),
	})),

	-- TODO: figure out how to just nest the existing fold snippets here
	s({trig = 'foldp', dscr = 'Vim fold marker pair'}, fmt([[
		{} {} {}{}

		{}

		{} {}{}
	]], {
		-- Open Marker
		f(util.get_comment),
		i(1, 'Fold description'),
		p(util.get_foldmarker, 'open'),
		i(2, '1'),
		-- Wrapped
		util.selection(3, 'SELECT_DEDENT'),
		-- Close marker
		f(util.get_comment),
		p(util.get_foldmarker, 'close'),
		rep(2),
	})),

	s({trig = 'modeline', dscr = 'Some common modelines'}, fmt('{} vim: {}', {
		f(util.get_comment),
		c(1, {
			sn(nil, fmt('{}et sta sw={} ts={} sts={}', {
				i(1),
				p(tostring, vim.bo.shiftwidth),
				p(tostring, vim.bo.tabstop),
				p(tostring, vim.bo.softtabstop),
			})),
			sn(nil, fmt('ft={}', f(function() return vim.bo.filetype end))),
			t 'fdm=marker',
			t '',
		}),
	})),

	s({trig = 'lorem', dscr = 'Lorem ipsum text (50 words)'}, t {
		'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod',
		'tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At',
		'vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,',
		'no sea takimata sanctus est Lorem ipsum dolor sit amet.',
	}),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
