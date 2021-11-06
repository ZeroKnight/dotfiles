-- WhichKey configuration

local wk = require 'which-key'

-- FIXME: https://github.com/folke/which-key.nvim/issues/166

wk.setup {
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 30,
    },
  },
  operators = {
    -- NOTE: These don't seem to have any affect...
    gc = 'Comments',
    ds = 'Delete Surrounding',
    cs = 'Change Surrounding',
    ys = 'Make Surrounding',
  },
  window = {
    border = 'single', -- NOTE: Doesn't appear to do anything yet
  },
}
