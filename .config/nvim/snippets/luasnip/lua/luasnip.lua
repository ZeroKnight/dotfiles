-- LuaSnip snippets

local ls = require 'luasnip'

local util = require 'plugins.snippet.util'

-- Wrapped snippet constructor that ensures snippets defined here are only
-- active when editing a snippet file.
local s = util.snippet_subtype {
  cond = function() return vim.api.nvim_buf_get_name(0):match 'nvim/snippets/luasnip' end,
}

-- stylua: ignore start
return {
	s({trig = 's', desc = 'New snippet'}, fmt("s({{{}}}, {}", {
		c(1, {
			sn(nil, fmt("trig = '{}', desc = '{}'", {
				i(1), i(2),
			})),
			sn(nil, fmt("trig = '{}', desc = '{}', regTrig = true", {
				i(1), i(2),
			})),
		}),
		c(2, {
			sn(nil, fmt([=[
				fmt([[
					{}
				]], {{
					{}
				}})),
			]=], {i(1), i(2)})),
			sn(nil, fmt([[
				fmt('{}', {{
					{}
				}})),
			]], {i(1), i(2)})),
			sn(nil, fmt([[
				{{
					{}
				}}),
			]], i(1))),
			sn(nil, fmt('{}),', i(1))),
		}),
	})),

	s({trig = 'sn', desc = 'Snippet node'}, fmt('sn({}, {}', {
		i(1, 'nil'),
		c(2, {
			sn(nil, fmt([[
				fmt('{}', {{
					{}
				}})),
			]], {i(1), i(2)})),
			sn(nil, fmt([=[
				fmt([[
					{}
				]], {{
					{}
				}})),
			]=], {i(1), i(2)})),
			sn(nil, fmt([[
				{{
					{}
				}}),
			]], i(1))),
			sn(nil, fmt('{}),', i(1))),
		}),
	})),

	s({trig = 'c', desc = 'Choice node'}, fmt([[
		c({}, {{
			{}
		}}),
	]], {
		i(1), i(2)
	})),

	s({trig = 'selection', desc = 'Function node for $TM_SELECTED_TEXT'},
		fmt("util.selection({}, '{}'{}{}),", {
			i(1, '1'),
			c(2, {t 'SELECT_DEDENT', t 'TM_SELECTED_TEXT', t 'SELECT_RAW'}),
			n(3, ', '),
			i(3, "'fallback text'"),
		})
	),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
