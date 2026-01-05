-- Ansible snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	s({trig = 't', desc = 'Template ({{ foo }})'}, {
		c(1, {
			sn(nil, fmta('{{ <> }}', { r(1, 'template', i(1)) })),
			sn(nil, fmta('"{{ <> }}<>"', { r(1, 'template', i(1)), i(2) })),
		}),
	}),

	s({trig = 'path', desc = 'Path join'}, {
		c(1, {
			sn(nil, fmt('({}, {}) | path_join', { r(1, 'a', i(1)), r(2, 'b', i(2)) })),
			sn(nil, fmta('{{ (<>, <>) | path_join }}', { r(1, 'a', i(1)), r(2, 'b', i(2)) })),
			sn(nil, fmta('"{{ (<>, <>) | path_join }}"', { r(1, 'a', i(1)), r(2, 'b', i(2)) })),
		}),
	}),

	s({trig = 'lookup', desc = 'lookup(...)'}, fmt("lookup('{}', {})", { i(1), i(2) })),

	s({trig = 'package', desc = 'Manage Packages (Generic))'}, fmt([[
		- name: {}
			become: true
			ansible.builtin.package:
				{}
	]], {
		i(1),
		c(2, {
			sn(nil, fmt([[
				name: {}
						state: {}
			]], {
				r(1, 'packages_inline', i(1)),
				r(2, 'state', i(2, 'present')),
			})),
			sn(nil, fmt([[
				state: {}
						name:
							- {}
			]], {
				r(2, 'state', i(2, 'present')),
				r(1, 'packages_list', i(1)),
			})),
		}),
	})),

	s({trig = 'file', desc = 'Manage files'}, fmt([[
		- name: {}
			ansible.builtin.file:
				{}
	]], {
		i(1),
		c(2, {
			sn(nil, fmt([[
				path: {}
						state: {}
			]], { i(1), r(2, 'state1', i(2, 'present')), })),
			sn(nil, fmt([[
				src: {}
						dest: {}
						state: {}
			]], { i(1), i(2), r(3, 'state2', i(3, 'link')), })),
		}),
	})),

	s({trig = 'copy', desc = 'Copy files'}, fmt([[
		- name: {}
			ansible.builtin.copy:
				{}
	]], {
		i(1),
		c(2, {
			sn(nil, fmt([[
				src: {}
						dest: {}
			]], { i(1), r(2, 'dest', i(2)), })),
			sn(nil, fmt([[
				dest: {}
						content: {}
			]], { r(2, 'dest', i(2)), i(1), })),
		}),
	})),

	s({trig = 'template', desc = 'ansible.builtin.template'}, fmt([[
		- name: {}
			ansible.builtin.template:
				src: {}
				dest: {}
	]], { i(1), i(2), i(3), })),

	s({trig = 'perms', desc = 'Common file permissions'}, {
		c(1, {
			sn(nil, fmt('mode: {}', { r(1, 'mode', i(1, '"0755"')) })),
			sn(nil, fmt([[
				owner: {}
				mode: {}
			]], { r(1, 'owner', i(1)), r(2, 'mode', i(2, '"0755"')) })),
			sn(nil, fmt([[
				owner: {}
				group: {}
				mode: {}
			]], { r(1, 'owner', i(1)), r(2, 'group', i(2)), r(3, 'mode', i(3, '"0755"')) })),
		}),
	}),

	s({trig = 'imp([trp])', desc = 'Import tasks/role/playbook', regTrig = true}, fmt([[
		- name: {}
			ansible.builtin.import_{}:{}
	]], {
		i(1),
		util.when_capture(1, { t = 'tasks', r = 'role', p = 'playbook', }),
		d(2, function(_, parent)
			local capture = util.get_snip(parent, 'captures')[1]
			-- import_playbook is free-form only
			if capture == 'p' then
				return sn(nil, { t' ', i(1) })
			end
			return sn(nil, {
				util.nl(),
				t '		',
				util.when_capture(1, { t = 'file', r = 'name' }),
				t ': ',
				i(1),
			})
		end),
	})),

	s({trig = 'inc([trv])', desc = 'Include tasks/role/vars', regTrig = true}, fmt([[
		- name: {}
			ansible.builtin.include_{}:
				{}: {}
	]], {
		i(1),
		util.when_capture(1, { t = 'tasks', r = 'role', v = 'vars', }),
		util.when_capture(1, { t = 'file', r = 'name', v = 'file', }),
		i(2),
	})),

	s({trig = 'af', desc = 'ansible_facts'}, fmt('ansible_facts{}', {
		c(1, {
			sn(nil, fmt('.{}', r(1, 'fact', i(1)))),
			sn(nil, fmt("['{}']", r(1, 'fact', i(1)))),
		}),
	})),

	s({trig = 'env', desc = 'Environment variable (ansible_facts)'}, fmt('ansible_facts{}', {
		c(1, {
			sn(nil, fmt('.env.{}', { r(1, 'env_var', i(1)) })),
			sn(nil, fmt("['env']['{}']", { r(1, 'env_var', i(1)) })),
		}),
	})),

	s({trig = 'play', desc = 'New play'}, fmt([[
		- name: {}
			hosts: {}
			{}
			tasks:
				- name: {}
	]], {
		i(1),
		i(2, 'localhost'),
		c(3, {
			sn(nil, fmt([[
				vars:
						{}
			]], { i(1) })),
			sn(nil, fmt([[
				vars_files:
						- {}
			]], { i(1) })),
		}),
		i(0)
	})),

	s({trig = 'task', desc = 'New task'}, fmt([[
		- name: {}
			{}.{}:
				{}
	]], {
		i(1),
		c(2, {
			t 'ansible.builtin',
			t 'community',
			t 'containers.podman',
			t '',
		}),
		i(3),
		i(0)
	})),

	s({trig = 'block', desc = 'Task block'}, fmt([[
		- name: {}
			{}
	]], {
		i(1),
		c(2, {
			sn(nil, fmt([[
				block:
					{}
			]], { i(1) })),
			sn(nil, fmt([[
				module_defaults:
					{}
				block:
					{}
			]], { i(1), i(2) })),
		}),
	})),

	s({trig = 'loop', desc = 'Loop task'}, {
		c(1, {
			sn(nil, fmt('loop: {}', { r(1, 'seq', i(1)) })),
			sn(nil, fmt([[
				loop: {}
				loop_control:
					label: {}
			]], {
				r(1, 'seq', i(1)),
				c(2, {
					sn(nil, fmta('"{{ item.<> }}"', i(1))),
					i(1),
				}),
			})),
		}),
	}),

}, { -- Autosnippets
		-- FIXME: Autopairs interferes with this
	-- s({trig = '{{', desc = 'Template'}, fmta('{{ <> }}', { i(0) })),
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
