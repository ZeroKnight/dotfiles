local uv = require 'luv'
local util = require 'zeroknight.util'
local Color = require('zeroknight.util.color').Color

local keymaps = require 'plugins.snippet.keymaps'

local snippets_path = join_stdpath('config', 'snippets/luasnip')
local external_snippets_path = join_stdpath('data', 'external_snippets')

---@type LazySpec
return {
  {
    'L3MON4D3/LuaSnip',
    keys = keymaps.keys,
    opts = function()
      local types = require 'luasnip.util.types'
      return {
        history = true,
        enable_autosnippets = true,
        store_selection_keys = keymaps.expand_key,
        update_events = { 'TextChanged', 'TextChangedI', 'InsertLeave' },
        region_check_events = { 'InsertEnter', 'InsertLeave', 'CursorHold' },
        delete_check_events = { 'InsertEnter', 'InsertLeave', 'CursorHold' },
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { '<- Choice', 'DiagnosticHint' } },
            },
          },
        },
      }
    end,
    init = function()
      vim.g.snips_author = 'Alex "ZeroKnight" George'

      vim.api.nvim_create_user_command('NewSnippet', function(cmd_opts)
        local new_file = string.format('%s/%s.lua', snippets_path, cmd_opts.args)
        uv.fs_copyfile(string.format('%s/_template.lua', snippets_path), new_file, { excl = not cmd_opts.bang })
        vim.cmd('e ' .. new_file)
      end, {
        bang = true,
        nargs = 1,
        desc = 'Create a new LuaSnip snippets file based on _template.lua and edit it',
        complete = function(arglead)
          return vim.tbl_map(
            function(x) return vim.fn.fnamemodify(x, ':t') end,
            vim.fn.globpath(snippets_path, arglead .. '*', false, true)
          )
        end,
      })
    end,
    config = function(_, opts)
      local ls = require 'luasnip'

      util.cmdf(
        'hi LuasnipChoiceNodeActive guibg=%s',
        Color:new(require('zeroknight.config.ui').colors.diagnostics.Hint):over(Color:from_background(), 0.18)
      )

      ls.config.setup(opts)
      ls.filetype_extend('python', { 'rst', '_documentation' })
      ls.filetype_extend('rst', { '_documentation' })
      ls.filetype_extend('markdown', { '_documentation' })
      ls.filetype_extend('zsh', { 'sh' })
      ls.filetype_extend('bash', { 'sh' })
      ls.filetype_extend('cpp', { 'c' })

      -- Load snippets
      require('luasnip.loaders.from_lua').lazy_load { paths = snippets_path }
      require('luasnip.loaders.from_vscode').lazy_load { paths = external_snippets_path }
    end,
  },
}
