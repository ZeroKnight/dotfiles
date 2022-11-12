-- nvim-autopairs Configuration

local npairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'
local cond = require 'nvim-autopairs.conds'

npairs.setup {
  map_c_w = true,
  fast_wrap = {
    map = '<M-w>',
    highlight_grey = 'Visual',
  },
}
