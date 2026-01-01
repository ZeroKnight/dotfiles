-- reStructuredText snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	-- Inline Markup

	s({trig = ':', dscr = 'Field list (:name: body'}, fmt(':{}: {}', {
		i(1, 'field name'), i(2, 'field body'),
	})),

	s({trig = '..', dscr = 'Directive (..)'}, fmt('.. {}:: {}', {
		i(1, 'directive'),
		util.selection(2, 'SELECT_DEDENT', 'directive body'),
	})),

	s({trig = 'sub', dscr = 'Substitution definition'}, fmt('.. |{}| {}:: {}', {
		i(1, 'name'), i(2, 'directive'), i(3, 'target')
	})),

	s({trig = 'img', dscr = 'Image directive'}, fmt('.. image:: {}', {
		i(1, 'img')
	})),

	-- Block Markup

	s({trig = '::', dscr = 'Literal block (::)'}, fmt([[
		::

			{}
	]], {
		util.selection(1, 'SELECT_DEDENT'),
	})),

	s({trig = '>>>', dscr = 'Doctest block (>>> 1 + 1)'}, fmt([[
		>>> {}
		{}
	]], {
		i(1),
		f(function(args)
			local a = args[1][1]
			if #a > 0 then
				local ok, res = pcall(vim.fn.pyeval, string.format('repr(%s)', a))
				return ok and res or ''
			end
			return ''
		end, 1),
	})),

	s({trig = 'toc', dscr = 'Table of Contents (toctree)'}, fmt([[
		.. toctree::
			:maxdepth: {}
	]], { i(1, '2') })),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
