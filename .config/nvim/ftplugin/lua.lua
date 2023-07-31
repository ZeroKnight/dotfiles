-- Lua filetype settings

local optl = vim.opt_local

optl.tabstop = 2
optl.shiftwidth = 2

-- Make it easy to look up Lua (via LuaRef) and Neovim API functions
optl.keywordprg = ':help'

if require('zeroknight.util').has_plugin 'nvim-surround' then
  local config = require 'nvim-surround.config'
  require('nvim-surround').buffer_setup {
    surrounds = {
      S = {
        add = function()
          local num_eq = tonumber(config.get_input 'Number of equals: ') or 0
          return {
            { string.format('[%s[', string.rep('=', num_eq)) },
            { string.format(']%s]', string.rep('=', num_eq)) },
          }
        end,
        find = function()
          -- Leverage custom @block_string textobject defined via mini.ai
          return config.get_selection { motion = 'aS' }
        end,
        delete = '(%[=*%[)().-(%]=*%])()',
      },
    },
  }
end
