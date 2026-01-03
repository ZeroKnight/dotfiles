-- C++ stdlib snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	s({trig = 's:', desc = 'std::'}, t 'std::'),

	s({trig = 'endl', desc = 'std::endl'}, t 'std::endl'),

	s({trig = 'str', desc = 'std::string'}, fmt('std::string {}', { i(1, 's') })),

	s({trig = 'map', desc = 'std::map'}, fmt('std::map<{}, {}> {}', { i(1, 'std::string'), i(2), i(3, 'm'), })),

	s({trig = 'vec', desc = 'std::vector'}, fmt('std::vector<{}> {}', { i(1, 'int'), i(2, 'v') })),

}, { -- Autosnippets
	s({trig = 'coutl? ', desc = 'std::cout << ...', regTrig = true}, fmt('std::cout << {}{}', {
		i(1),
		util.if_trigger('l $', ' << std::endl;'),
	})),

	s({trig = 'cerrl? ', desc = 'std::cerr << ...', regTrig = true}, fmt('std::cerr << {}{}', {
		i(1),
		util.if_trigger('l $', ' << std::endl;'),
	})),

	s({trig = 'clogl? ', desc = 'std::clog << ...', regTrig = true}, fmt('std::clog << {}{}', {
		i(1),
		util.if_trigger('l $', ' << std::endl;'),
	})),

	s({trig = 'cin ', desc = 'std::cin >> ...', regTrig = true}, { t 'std::cin >> ', i(1) }),
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
