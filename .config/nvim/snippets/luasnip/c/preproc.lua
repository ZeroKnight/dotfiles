-- C Preprocessor snippets

--# selene: allow(undefined_variable)

local util = require 'plugin.luasnip.util'

-- stylua: ignore start
return {
	s({trig = 'inc', dscr = '#include'}, fmt('#include {}', {
		c(1, {
			d(1, function()
				if vim.bo.filetype == 'cpp' then
					return sn(nil, fmt('<{}>', i(1, 'iostream')))
				else
					return sn(nil, fmt('<{}.h>', i(1, 'stdio')))
				end
			end),
			sn(nil, fmt('"{}.h"', {
				d(1, function()
					local bufname = vim.api.nvim_buf_get_name(0)
					if vim.fn.fnamemodify(bufname, ':e') == 'c' then
						return sn(nil, i(1, vim.fn.fnamemodify(bufname, ':t:r')))
					end
					return sn(nil, i(1))
				end),
			})),
		}),
	})),

	s({trig = 'def', dscr = '#define'}, fmt('#define {}', { i(1) })),

	s({trig = '#e?if', dscr = '#if ... #endif', regTrig = true}, fmt([[
		#{}if {}
		{}{}
	]], {
		util.if_trigger('^#e', 'el'),
		i(1),
		util.selection(2, 'SELECT_DEDENT'),
		util.if_trigger('^#i', {'', '#endif'}),
	})),

	s({trig = '#el', dscr = '#else ...'}, fmt([[
		#else
		{}
	]], { util.selection(1, 'SELECT_DEDENT') })),

	s({trig = 'ifn?def', dscr = '#if(n)def ... #endif', regTrig = true}, fmt([[
		#if{}def {}
		{}
		#endif /* {} */
	]], {
		util.if_trigger('^ifn', 'n'),
		i(1),
		util.selection(2, 'SELECT_DEDENT'),
		rep(1),
	})),

	s({trig = 'guard', dscr = 'Header guard'}, fmt([[
		#ifndef PATH_{}_INCLUDED
		#define PATH_{}_INCLUDED

		{}

		#endif /* PATH_{}_INCLUDED */
	]], {
		d(1, function()
			local bufname = vim.api.nvim_buf_get_name(0)
			return sn(nil, i(1, vim.fn.fnamemodify(bufname, ':t'):gsub('[^%w]+', '_'):upper()))
		end),
		rep(1),
		util.selection(2, 'SELECT_DEDENT'),
		rep(1),
	})),

}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
