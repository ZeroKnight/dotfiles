-- PowerShell shortcut snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	s({trig = 'custom', desc = 'PSCustomObject'}, fmt([[
		[PSCustomObject]@{{
			{} = {}
		}}
	]], { i(1, 'Name'), i(2, 'Value') })),

	s({trig = 'catch-err', desc = 'Write-Error -Exception ...'}, fmt([[
		Write-Error -Exception $_.Exception -Message "{}: $_"{}
	]], { i(1), i(0) })),

	s({trig = 'cprop', desc = 'Calculated Property'}, fmta("@{Name='<>';Expression={<>}}", {
		i(1, 'PropertyName'),
		util.selection(2, 'SELECT_DEDENT'),
	})),

	s({trig = 'compname-param', desc = 'ComputerName Parameter'}, fmt([=[
		[Parameter(ValueFromPipelineByPropertyName)]
		[String[]]
		$ComputerName{}
	]=], { i(0) })),

	s({trig = 'cred-param', desc = 'Credential Parameter'}, fmt([[
		[Parameter()]
		[ValidateNotNull()]
		[System.Management.Automation.Credential()]
		[PSCredential]
		$Credential = [PSCredential]::Empty{}
	]], { i(0) })),

  s({trig = 'ifn?b', desc = "if (not) $PSBoundParameters.ContainsKey('Param')", regTrig = true}, fmta([[
    if (<>$PSBoundParameters.ContainsKey('<>')) {
      <>
    }
  ]], { util.if_trigger('nb$', '-not '), i(1), i(2) })),

  s({trig = 'ifn?p', desc = 'if (not) Test-Path', regTrig = true}, fmta([[
    if (<><>Test-Path $<><>) {
      <>
    }
  ]], {
  	util.if_trigger('np$', '-not '),
  	util.if_trigger('np$', '('),
		i(1, 'Path'),
  	util.if_trigger('np$', ')'),
  	i(2)
  })),

	s({trig = 'conditional', desc = 'PowerShell 5.1 pseudo-conditional expression'}, {
		c(1, {
			sn(nil, fmta('if (<>) { <> } else { <> }', {
				r(1, 'cond', i(1)),
				r(2, 'if-true', i(1)),
				r(3, 'if-false', i(1)),
			})),
			sn(nil, fmta('$(if (<>) { <> } else { <> })', {
				r(1, 'cond', i(1)),
				r(2, 'if-true', i(1)),
				r(3, 'if-false', i(1)),
			})),
		}),
	}),

	s({trig = 'if-cred', desc = 'if PSCredential'}, fmt([[
		if ($Credential -ne [PSCredential]::Empty) {{
			{}
		}}
	]], {
		c(1, {
			sn(nil, fmt('${}.Credential = $Credential{}', { i(1, 'Args'), i(2) })),
			t '',
		}),
	})),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
