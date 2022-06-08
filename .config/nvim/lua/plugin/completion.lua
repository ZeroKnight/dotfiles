-- Completion Settings

local cmp = require 'cmp'
local kinds = require 'zeroknight.lsp.kinds'

vim.opt.completeopt = { 'menuone', 'noselect' } -- Required by cmp

local function wrap_visible(func)
  return function(fallback)
    if cmp.visible() then
      func()
    else
      fallback()
    end
  end
end

local menu_text = {
  buffer = 'buf',
  nvim_lsp = 'LSP',
  nvim_lua = 'vim.api',
  path = 'path',
  ultisnips = 'snip',
}

local compare = setmetatable({}, {
  __index = function(_, k)
    return cmp.config.compare[k]
  end,
})

function compare.underscores(entry1, entry2)
  -- Copied from lukas-reineke/cmp-under-comparator
  local _, entry1_under = entry1.completion_item.label:find '^_+'
  local _, entry2_under = entry2.completion_item.label:find '^_+'
  entry1_under = entry1_under or 0
  entry2_under = entry2_under or 0
  if entry1_under > entry2_under then
    return false
  elseif entry1_under < entry2_under then
    return true
  end
end

cmp.setup {
  enabled = true,
  completion = {
    keyword_length = 2,
  },
  experimental = {
    ghost_text = true,
  },
  preselect = cmp.PreselectMode.Item, -- Auto-select the source-specified item

  snippet = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args.body)
    end,
  },

  formatting = {
    format = function(entry, item)
      local name = menu_text[entry.source.name]
      item.kind = string.format('%s  %s', kinds.symbols[item.kind] or '?', item.kind)
      item.menu = name and string.format('[%s]', name) or ''
      return item
    end,
  },

  sorting = {
    comparators = {
      compare.offset,
      compare.exact,
      -- compare.scopes,
      compare.sort_text,
      compare.score,
      compare.recently_used,
      compare.locality,
      compare.underscores,
      compare.kind,
      compare.length,
      compare.order,
    },
  },

  mapping = {
    ['<CR>'] = function(fallback)
      if cmp.visible() then
        -- Only confirm() if we've selected something, otherwise just <CR>
        if cmp.get_selected_entry() ~= nil then
          cmp.confirm()
        else
          cmp.close()
          fallback()
        end
      else
        -- Support plugins like Lexima that may remap <CR>
        fallback()
      end
    end,
    ['<C-e>'] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ['<Tab>'] = cmp.mapping {
      i = wrap_visible(function()
        cmp.select_next_item()
      end),
      c = cmp.mapping.select_next_item(),
    },
    ['<S-Tab>'] = cmp.mapping {
      i = wrap_visible(function()
        cmp.select_prev_item()
      end),
      c = cmp.mapping.select_prev_item(),
    },
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  },

  sources = cmp.config.sources {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'ultisnips' },
    { name = 'calc' },
    { name = 'buffer', keyword_length = 5 },
  },
}

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cc_types', keyword_length = 1 },
    { name = 'cmp_git' },
  }, {
    { name = 'path' },
    { name = 'ultisnips' },
    { name = 'calc' },
    { name = 'buffer' },
  }),
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'calc' },
  }, {
    { name = 'cmdline' },
  }),
})

cmp.setup.cmdline('/', {
  sources = cmp.config.sources {
    { name = 'calc' },
    { name = 'buffer' },
  },
})

-- Set up highlights
vim.cmd [[
  hi link CmpItemAbbrMatch Function
  hi link CmpItemAbbrMatchFuzzy Statement
]]

for group, link in pairs { CmpItemAbbrDeprecated = 'Error', CmpItemKind = 'Title', CmpItemMenu = 'NonText' } do
  if not pcall(vim.api.nvim_get_hl_by_name, group, false) then
    vim.cmd(string.format('hi link %s %s', group, link))
  end
end

local kind_colors = {
  Class = 'Type',
  Field = 'String',
  Interface = 'Type',
  Method = 'Function',
  Module = 'Type',
  Namespace = 'Type',
  Package = 'Statement',
  Property = 'Identifier',
  Snippet = 'SpecialKey',
  Variable = 'Identifier',
}
for kind, _ in pairs(kinds.symbols) do
  if not pcall(vim.api.nvim_get_hl_by_name, 'CmpItemKind' .. kind, false) then
    local explicit = kind_colors[kind]
    if explicit ~= nil then
      vim.cmd(string.format('hi link CmpItemKind%s %s', kind, explicit))
    elseif pcall(vim.api.nvim_get_hl_by_name, kind, false) then
      vim.cmd(string.format('hi link CmpItemKind%s %s', kind, kind))
    end
  end
end
