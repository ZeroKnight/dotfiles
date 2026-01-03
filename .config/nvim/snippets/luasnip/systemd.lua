-- systemd snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	s({trig = 'unit', desc = 'Unit section'}, fmt([[
		[Unit]
		Description={}
	]], { i(1) })),

	s({trig = 'service', desc = 'Service section'}, fmt([[
		[Service]
		Type={}
	]], {
		c(1, { t 'simple',
			t 'exec',
			t 'forking',
			t 'oneshot',
			t 'dbus',
			t 'notify',
			t 'idle',
		}),
	})),

	s({trig = 'install', desc = 'Install section'}, fmt([[
		[Install]
		WantedBy={}
	]], {
		c(1, {
			t '',
			t 'default.target',
			t 'multi-user.target',
			t 'graphical.target',
			t 'network-online.target',
			t 'timers.target',
		}),
	})),

	s({trig = 'timer', desc = 'Timer section'}, fmt([[
		[Timer]
		{}={}
	]], {
		c(1, {
				t 'OnCalendar',
				t 'OnActiveSec',
				t 'OnBootSec',
				t 'OnStartupSec',
				t 'OnUnitActiveSec',
				t 'OnUnitInactiveSec'
		}),
		i(2),
	})),

}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
