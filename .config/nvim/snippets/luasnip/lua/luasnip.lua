-- LuaSnip snippets

local ls = require 'luasnip'

local util = require 'plugins.snippet.util'

-- Wrapped snippet constructor that ensures snippets defined here are only
-- active when editing a snippet file. Their priority is set higher than usual
-- so that when they are active, they take precedence over non-snippet-related
-- triggers.
local s = function(t, nodes, opts)
  if type(t) == 'string' then
    t = { trig = t }
  end
  -- Take priority when actually active
  t.priority = t.priority and t.priority + 10000 or 11000

  local cond = function() return vim.api.nvim_buf_get_name(0):match 'nvim/snippets/luasnip' end
  opts = vim.tbl_extend('keep', opts or {}, {
    condition = cond,
    show_condition = cond,
  })

  return ls.s(t, nodes, opts)
end

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
