-- PowerShell function snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'

-- stylua: ignore start
return {
	s({trig = 'fn', desc = 'function definition'}, fmt([[
		function {}({}) {{
			{}
		}}
	]], {
		i(1, 'name'),
		i(2),
		util.selection(3, 'SELECT_DEDENT'),
	})),

	s({trig = 'fna', desc = 'advanced function definition'}, fmta([[
		function <> {
			[CmdletBinding()]
			param (
				<>
			)

			<>
		}
	]], {
		i(1, 'Verb-Noun'),
		i(2),
		util.selection(3, 'SELECT_DEDENT'),
	})),

	s({trig = 'pblock', desc = 'param block'}, {
		c(1, {
			sn(nil, fmt([[
				[CmdletBinding()]
				param (
					{}
				)
			]], { r(1, 'parameters', i(1)) })),
			sn(nil, fmt([[
				param (
					{}
				)
			]], { r(1, 'parameters', i(1)) })),
		}),
	}),

  s({trig = 'param', desc = 'advanced function parameter'}, fmt([[
    [Parameter({})]
    [{}]
    ${}
  ]], { i(1), i(2, 'String'), i(3, 'Name') })),

  s({trig = 'bpe', desc = 'begin, process, end blocks'}, {
    c(1, {
      sn(nil, fmta([[
        begin {
          <>
        }
      ]], { r(1, 'begin', i(1)) })),
      sn(nil, fmta([[
        begin {
          <>
        }

        process {
          <>
        }
      ]], { r(1, 'begin', i(1)), r(2, 'process', i(1)) })),
      sn(nil, fmta([[
        begin {
          <>
        }

        process {
          <>
        }

        end {
          <>
        }
      ]], { r(1, 'begin', i(1)), r(2, 'process', i(1)), r(3, 'end', i(1)) })),
    }),
  }),

  s({trig = 'splat', desc = 'Set up a hashtable to splat function arguments'}, fmt([[
    ${} = @{{
      {} = {}
    }}
    {} @{}
  ]], { i(1, 'Args'), i(2, 'Parameter'), i(3, 'Value'), i(4, 'Function'), rep(1) })),

  s({trig = 'help', desc = 'Comment-based help for an advanced function'}, fmt([[
    <#
    .SYNOPSIS
    {}

    .DESCRIPTION
    {}

    .NOTES
    {}
    #>
  ]], {
    i(1, 'Short, declarative, one-line summary'),
    i(2, 'Detailed description of the function, its purpose, use cases, etc.'),
    i(3)
  })),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
