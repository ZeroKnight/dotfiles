-- Podman Quadlet snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

local s = util.snippet_subtype {
  cond = function() return vim.api.nvim_buf_get_name(0):match 'containers' end,
}

-- stylua: ignore start
return {
	s({trig = 'quadlet', desc = 'New Quadlet template'}, fmt([[
		# vim: ft=systemd

		[Unit]
		Description={}

		[Service]
		Restart={}

		{}
	]], {
		i(1),
		c(2, {
			t 'on-failure',
			t 'on-abnormal',
			t 'on-success',
			t 'always',
		}),
		c(3, {
			sn(nil, fmt([[
				[Container]
				Image={}
				{}={}
			]], {
				i(1),
				c(2, { t 'Pod', t 'PublishPorts' }),
				i(0),
			})),
			t '[Volume]',
			sn(nil, fmt([[
				[Pod]
				PublishPorts={}
			]], { i(1) })),
		}),
	})),

	s({trig = 'port', desc = 'Publish port(s) (host:container)'}, fmt('PublishPort={}:{}', { i(1, '8080'), i(2) })),
	s({trig = 'vol', desc = 'Volume mount'}, fmt('Volume={}:{}', { i(1), i(2) })),

}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
