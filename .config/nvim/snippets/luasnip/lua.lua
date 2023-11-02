-- Lua snippets

--# selene: allow(undefined_variable)

local util = require 'plugins.snippet.util'

-- Return the last portion of a Lua import string, e.g. a.b.c -> c
local function get_import_tail(import)
  local parts = vim.split(import, '.', { plain = true })
  return parts[#parts]:gsub('-', '_') or ''
end

-- Return a dynamic node that expands to the tail of an import string at the
-- jumpable node at position `from`. If `stop` is true, then the tail will
-- be made as an insert node, or a text node otherwise.
local function import_tail(pos, from, stop)
  local node
  if stop then
    node = function(x)
      return i(1, get_import_tail(x))
    end
  else
    node = function(x)
      return t(get_import_tail(x))
    end
  end
  return d(pos, function(args)
    return sn(nil, node(args[1][1]))
  end, from)
end

-- stylua: ignore start
return {
	s({trig = 'req', dscr = 'require'}, fmt("{}{}{}require('{}')", {
		n(2, 'local '),
		import_tail(2, 1, true),
		n(2, ' = '),
		i(1),
	})),

	s({trig = 'luv', dscr = 'import luv'}, t "local uv = require('luv')"),

	s({trig = 'l', dscr = 'New local variable'}, fmt('local {} = {}', {
		i(1, 'x'),
		i(0)
	})),

	s({trig = 'lf', dscr = 'Local shortcut to a field, e.g. `local biz = foo.bar.biz`'}, fmt('local {} = {}', {
		import_tail(2, 1, false),
		i(1),
	})),

	s({trig = 'l?fn', dscr = 'Function definition', regTrig = true}, fmt([[
		{}function{}{}({})
			{}
		end
	]], {
		util.if_trigger('^l', 'local '),
		n(1, ' '),
		i(1), i(2),
		util.selection(3, 'SELECT_DEDENT'),
	})),

	s({trig = 'fni', dscr = 'Function definition (inline)'}, fmt('function({}) {} end', {
		i(1), i(2),
	})),

	s({trig = 'for', dscr = 'for loop'}, fmt([[
		for {} do
			{}
		end
	]], {
		c(1, {
			sn(nil, fmt('{}, {} in {}({})', {
				d(2, function(args) return sn(nil, args[1][1] == 'ipairs' and i(1, '_') or i(1, 'k')) end, 1),
				i(3, 'v'),
				c(1, { t 'ipairs', t 'pairs' }),
				i(4),
			})),
			sn(nil, fmt('{} = {}, {}', {
				i(1, 'i'), i(2, '1'), i(3),
			})),
		}),
		util.selection(2, 'SELECT_DEDENT'),
	})),

	s({trig = 'forl', dscr = 'Iterate over lines in file'}, fmt([[
		for {} in {}:lines() do
			{}
		end
	]], {
		i(1, 'lines'), i(2, 'file'),
		util.selection(3, 'SELECT_DEDENT'),
	})),

	s({trig = 'wh', dscr = 'while loop'}, fmt([[
		while {} do
			{}
		end
	]], {
		i(1, 'true'),
		util.selection(2, 'SELECT_DEDENT'),
	})),

	s({trig = 'repeat', dscr = 'repeat ... until'}, fmt([[
		repeat
			{}
		until {}
	]], {
		util.selection(2, 'SELECT_DEDENT'),
		i(1),
	})),

	-- NOTE: I hate having to separately define if/elseif, but I ran into weird
	-- indentation problems with my optional "end". Seems like a LuaSnip bug.
	s({trig = 'if', dscr = 'if statement'}, fmt([[
		if {} then
			{}{}
	]], {
		i(1),
		util.selection(2, 'SELECT_DEDENT'),
		c(3, {
			t { '', 'end' },
			sn(nil, fmt([[
				{}else
					{}
				end
			]], { util.nl(), i(1) })),
			sn(nil, fmt([[
				{}elseif {} then
					{}
				end
			]], { util.nl(), i(1), i(2) })),
			sn(nil, fmt([[
				{}elseif {} then
					{}
				else
					{}
				end
			]], { util.nl(), i(1), i(2), i(3) })),
		}),
	})),

	s({trig = 'eif', dscr = 'elseif statement'}, fmt([[
		elseif {} then
			{}{}
	]], {
		i(1),
		util.selection(2, 'SELECT_DEDENT'),
		c(3, {
			t '',
			sn(nil, fmt([[
				{}else
					{}
				end
			]], { util.nl(), i(1) })),
			sn(nil, fmt([[
				{}elseif {} then
					{}
				end
			]], { util.nl(), i(1), i(2) })),
			sn(nil, fmt([[
				{}elseif {} then
					{}
				else
					{}
				end
			]], { util.nl(), i(1), i(2), i(3) })),
		}),
	})),

	s({trig = 'e?ifnn?', dscr = '(else)if x is (not) nil', regTrig = true}, fmt([[
		{}if {} {} nil then
			{}{}
	]], {
		util.if_trigger('^e', 'else'),
		i(1, 'x'),
		util.if_trigger('nn$', '~=', '=='),
		util.selection(2, 'SELECT_DEDENT'),
		util.if_trigger('^i', { '', 'end' }),
	})),

	s({trig = 'el', dscr = 'else statement'}, fmt([[
		else
			{}
	]], {
		util.selection(1, 'SELECT_DEDENT'),
	})),

	s({trig = 'do', dscr = 'do block'}, fmt([[
		do
			{}
		end
	]], {
		util.selection(1, 'SELECT_DEDENT'),
	})),

	s({trig = 'bcom', dscr = 'Block comment'}, fmt([[
		--[{}[
		{}
		--]{}]
	]], {
		i(1),
		util.selection(2, 'SELECT_DEDENT'),
		rep(1),
	})),
}, { -- Autosnippets
	s({trig = '#!', dscr = 'shebang'}, fmt([[
		#!/usr/bin/env {}

		{}
	]], {
		c(1, {t 'lua', t 'luajit'}),
		i(0)
	})),
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
