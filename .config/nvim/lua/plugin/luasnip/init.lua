-- LuaSnip configuration

local ls = require 'luasnip'
local types = require 'luasnip.util.types'
local uv = require 'luv'

vim.g.snips_author = 'Alex "ZeroKnight" George'

local snippets_path = as_stdpath('config', 'snippets/luasnip')
local expand_key = '<C-k>'

ls.config.setup {
  history = true,
  enable_autosnippets = true,
  store_selection_keys = expand_key,
  update_events = 'TextChanged,TextChangedI',
  region_check_events = 'InsertEnter,CursorHold,CursorMoved',
  delete_check_events = 'InsertLeave,TextChanged',
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '<- Choice', 'DiagnosticHint' } },
      },
    },
  },
}

ls.filetype_extend('python', { 'rst', '_documentation' })
ls.filetype_extend('rst', { '_documentation' })
ls.filetype_extend('markdown', { '_documentation' })
ls.filetype_extend('zsh', { 'sh' })
ls.filetype_extend('bash', { 'sh' })
ls.filetype_extend('cpp', { 'c' })

vim.keymap.set({ 'i', 's' }, expand_key, function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, {
  desc = 'Expand snippet or jump to next placeholder',
})

vim.keymap.set({ 'i', 's' }, '<C-j>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, {
  desc = 'Jump to previous snippet placeholder',
})

for key, opts in pairs { n = { dir = 1, word = 'next' }, p = { dir = -1, word = 'prev' } } do
  vim.keymap.set({ 'i', 's' }, string.format('<M-%s>', key), function()
    if ls.choice_active() then
      ls.change_choice(opts.dir)
    end
  end, {
    desc = string.format('Cycle to the %s LuaSnip choice', opts.word),
  })
end

vim.keymap.set({ 'i', 's' }, '<C-l>', function()
  if ls.choice_active() then
    require 'luasnip.extras.select_choice'()
  end
end, {
  desc = 'Select a LuaSnip choice to use',
})

vim.keymap.set('s', '<BS>', '<BS><Cmd>startinsert<CR>', {
  silent = true,
  desc = 'Make <BS> drop to insert mode as well. Especially helpful when clearing a snippet placeholder.',
})

vim.api.nvim_create_user_command('NewSnippet', function(opts)
  local new_file = string.format('%s/%s.lua', snippets_path, opts.args)
  uv.fs_copyfile(string.format('%s/_template.lua', snippets_path), new_file, { excl = not opts.bang })
  vim.cmd('e ' .. new_file)
end, {
  bang = true,
  nargs = 1,
  desc = 'Create a new LuaSnip snippets file based on _template.lua and edit it',
  complete = function(arglead)
    return vim.tbl_map(function(x)
      return vim.fn.fnamemodify(x, ':t')
    end, vim.fn.globpath(
      snippets_path,
      arglead .. '*',
      false,
      true
    ))
  end,
})

-- Load snippets
require('luasnip.loaders.from_lua').lazy_load { paths = snippets_path }
