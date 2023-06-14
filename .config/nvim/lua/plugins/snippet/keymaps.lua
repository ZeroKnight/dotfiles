-- Keymaps related to snippets

local M = {
  expand_key = '<C-k>',
}

M.keys = {
  {
    '<Leader>se',
    function()
      require('luasnip.loaders').edit_snippet_files()
    end,
    desc = 'Edit snippets for this filetype',
  },
  {
    '<Leader>sr',
    function()
      local cfg = require 'lazy.core.config'
      local plugin = cfg.plugins['LuaSnip']
      ---@diagnostic disable-next-line missing-parameter param-type-mismatch
      plugin:config(plugin.opts())
    end,
    desc = 'Reload LuaSnip',
  },
  {
    M.expand_key,
    function()
      if require('luasnip').expand_or_jumpable() then
        require('luasnip').expand_or_jump()
      end
    end,
    desc = 'Expand snippet or jump to next placeholder',
    mode = { 'i', 's' },
  },
  {
    '<C-j>',
    function()
      if require('luasnip').jumpable(-1) then
        require('luasnip').jump(-1)
      end
    end,
    desc = 'Jump to previous snippet placeholder',
    mode = { 'i', 's' },
  },
  {
    '<M-n>',
    function()
      if require('luasnip').choice_active() then
        require('luasnip').change_choice(1)
      end
    end,
    desc = 'Cycle to the next LuaSnip choice',
    mode = { 'i', 's' },
  },
  {
    '<M-p>',
    function()
      if require('luasnip').choice_active() then
        require('luasnip').change_choice(-1)
      end
    end,
    desc = 'Cycle to the previous LuaSnip choice',
    mode = { 'i', 's' },
  },
  {
    '<C-l>',
    function()
      if require('luasnip').choice_active() then
        require 'luasnip.extras.select_choice'()
      end
    end,
    desc = 'Select a LuaSnip choice to use',
    mode = { 'i', 's' },
  },
  {
    '<BS>',
    '<BS><Cmd>startinsert<CR>',
    desc = 'Make <BS> drop to insert mode as well. Especially helpful when clearing a snippet placeholder.',
    silent = true,
    mode = 's',
  },
}

return M
