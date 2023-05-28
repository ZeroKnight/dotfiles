-- C++ snippets

--# selene: allow(undefined_variable)

local util = require 'plugins.snippet.util'

local function maybe_stem(pos)
  return d(pos, function()
    local stem = util.file_stem()
    return #stem and stem or 'Foo'
  end)
end

-- stylua: ignore start
return {
	s({trig = 'cr', dscr = 'const reference: const foo&'}, fmt('const {}& {}', { i(1, 'std::string'), i(2) })),

	s({trig = 'ns', dscr = 'namespace'}, fmt([[
		namespace {} {{
			{}
		}}
	]], { maybe_stem(1), util.selection(2, 'SELECT_DEDENT'), })),

}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
