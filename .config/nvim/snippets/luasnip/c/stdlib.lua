-- C stdlib snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

local fspec_regex = [=[
	\v\%[-\+ #0]*(\d+|\*)?\.?(\d+|\*)?(hh?|ll?|[jztL])?[csdioxXufFeEaAgGnp]
]=]
fspec_regex = vim.fn.trim(fspec_regex)

-- stylua: ignore start

return {
	-- IO

	s({trig = 'v?f?w?pf', desc = '(f)printf family', regTrig = true}, fmt('{}{}{}printf({}"{}\\n"{}{});', {
		util.if_trigger('^v', 'v'),
		util.if_trigger('^v?f', 'f'),
		util.if_trigger('wpf$', 'w'),
		d(1, function(_, snip)
			if snip.trigger:match('^v?f') then
				return sn(nil, fmt('{}, ', { i(1, 'stderr') }))
			end
			return sn(nil, t '')
		end),
		i(2, '%s'),
		m(2, function(args) return vim.regex(fspec_regex):match_str(args[1][1]) end, ', '),
		d(3, function(args, snip)
			if snip.trigger:match('^v') then
				return sn(nil, i(1, 'vlist'))
			else
				return util.generate_insertnodes(fspec_regex, { regex = true })(args)
			end
		end, 2),
	})),

	s({trig = 'v?s[nw]?pf', desc = 'sprintf family', regTrig = true}, fmt('{}s{}printf({}, {}"{}\\n"{}{});', {
		util.if_trigger('^v', 'v'),
		util.when_trigger { n = 'n', w = 'w' },
		i(1, 'buffer'),
		d(2, function(_, snip)
			if snip.trigger:match('[nw]') then
				return sn(nil, fmt('{}, ', i(1, 'n')))
			end
			return sn(nil, t '')
		end),
		i(3, '%s'),
		m(3, function(args) return vim.regex(fspec_regex):match_str(args[1][1]) end, ', '),
		d(4, function(args, snip)
			if snip.trigger:match('^v') then
				return sn(nil, i(1, 'vlist'))
			else
				return util.generate_insertnodes(fspec_regex, { regex = true })(args)
			end
		end, 3),
	})),

}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
