-- systemd snippets

--# selene: allow(undefined_variable)

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	s({trig = 'unit', dscr = 'Unit section'}, fmt([[
		[Unit]
		Description={}
	]], { i(1) })),

	s({trig = 'service', dscr = 'Service section'}, fmt([[
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

	s({trig = 'install', dscr = 'Install section'}, fmt([[
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

	s({trig = 'timer', dscr = 'Timer section'}, fmt([[
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
