-- C shortcuts and boilerplate

--# selene: allow(undefined_variable)

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	s({trig = 'main', dscr = 'int main() { ... }'}, fmt([[
		int main(int argc, char *argv[]) {{
			{}{}
			return 0;
		}}
	]], { i(1), i(0) })),

}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
