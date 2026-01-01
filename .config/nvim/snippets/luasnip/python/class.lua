-- Python class-related snippets

---@module 'luasnip'

local util = require 'plugins.snippet.util'
local isn = require('luasnip').indent_snippet_node

local function get_parents(ts)
  local parents = {}
  for _, line in ipairs(ts) do
    if line:match '%(' then
      vim.list_extend(parents, vim.split(line:gsub('%w+%(', ''):gsub('%)', ''), ',%s*'))
    end
  end
  return parents
end

local function get_params(ts)
  local params = {}
  for _, line in ipairs(ts) do
    for _, param in ipairs(vim.split(line, ',%s*')) do
      local name, anno, val = unpack(vim.split(param, '%s*[=:]%s*'))
      if name and #name > 0 and name ~= 'self' then
        table.insert(params, { name = name, anno = anno, val = val })
      end
    end
  end
  return params
end

local function init_body(pos, parents_pos, params_pos)
  return d(pos, function(args)
    local nodes = {}
    local parents = get_parents(args[1])
    local params = get_params(args[2])
    if #parents > 0 then
      if #parents > 1 then
        local super_calls = {}
        for _, parent in ipairs(parents) do
          table.insert(super_calls, string.format('super(%s, self).__init__()', parent))
        end
        table.insert(nodes, t(super_calls))
      else
        table.insert(nodes, t 'super().__init__()')
      end
    else
      table.insert(nodes, t '')
    end
    local param_inits = {}
    for _, param in pairs(params) do
      table.insert(param_inits, string.format('self.%s = %s', param.name, param.name))
    end
    if #param_inits > 0 then
      table.insert(nodes, t(param_inits))
    else
      table.insert(nodes, t '')
    end
    if #parents > 0 and #params > 0 then
      table.insert(nodes, 2, t { '', '' })
    end
    -- NOTE: $PARENT_INDENT is the root snippet indent level, NOT the dynamic_node
    return isn(nil, nodes, '$PARENT_INDENT\t\t')
  end, {
    parents_pos,
    params_pos,
  })
end

-- stylua: ignore start
return {
	s({trig = 'cname', dscr = 'class name'}, t 'type(self).__name__'),

	s({trig = 'super', dscr = 'super call'}, fmt('super({}).{}({})', {
		c(1, {
			t '',
			sn(nil, fmt('{}, self', { i(1) })),
		}),
		i(2, '__init__'),
		i(3)
	})),

	s({trig = 'str', dscr = '__str__ method'}, fmt([[
		def __str__(self):
			{}
	]], { i(1, 'pass') })),

	s({trig = 'repr', dscr = '__repr__ method'}, fmt([[
		def __repr__(self):
			return f'<{{type(self).__name__}} {}>'
	]], { i(1) })),

	s({trig = 'prop', dscr = 'property decorator'}, fmt([[
		@property
		def {name}(self){ret_anno}:
			"""{docstring}{close_doc}
			{fn_body}
	]], {
		name = i(1, 'foo'),
		ret_anno = c(2, {
			sn(nil, fmt(' -> {}', { i(1, 'T') }, { dedent = false })),
			t '',
		}),
		docstring = util.python.docstring_summary(3, 1),
		close_doc = util.python.close_docstring(3),
		fn_body = util.selection(4, 'SELECT_DEDENT', 'pass'),
	})),

	s({trig = 'setter', dscr = 'setter property'}, fmt([[
		@{}.setter
		def {}(self, {}):
			{}
	]], {
		i(1, 'foo'),
		rep(1),
		i(2),
		util.selection(3, 'SELECT_DEDENT', 'pass'),
	})),

	s({trig = 'deleter', dscr = 'deleter property'}, fmt([[
		@{}.deleter
		def {}(self):
			{}
	]], {
		i(1, 'foo'),
		rep(1),
		util.selection(2, 'SELECT_DEDENT', 'pass'),
	})),

	-- TODO: Expand params in docstring when I settle on a docstring style
	s({trig = 'cl', dscr = 'class definition'}, fmt([[
		class {name}:
			"""{docstring}{close_doc}

			def __init__(self{comma}{args}):
				{init_body}
	]], {
		name = i(1, 'Foo'),
		docstring = util.python.docstring_summary(2, 1),
		close_doc = util.python.close_docstring(2),
		comma = n(3, ', '),
		args = i(3),
		init_body = init_body(4, 1, 3),
	})),

	s({trig = 'dcl', dscr = 'dataclass'}, fmt([[
		@dataclass
		class {}:
			"""{}{}

			{}
	]], {
		i(1, 'Foo'),
		util.python.docstring_summary(2, 1),
		util.python.close_docstring(2),
		util.selection(3, 'SELECT_DEDENT', 'pass'),
	})),

	s({trig = 'field', dscr = 'dataclass field'}, fmt('field({})', {
		c(1, {
			sn(nil, fmt('default={}', { i(1) })),
			sn(nil, fmt('default_factory={}', { i(1) })),
			t 'repr=False',
		}),
	})),

	s({trig = 'pinit', dscr = 'dataclass __post_init__'}, fmt([[
		def __post_init__(self):
			{}
	]], { i(1) })),
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
