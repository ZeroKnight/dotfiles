-- Nvim-Cmp comparison functions

local cmp = require 'cmp'

local compare = setmetatable({}, {
  __index = function(_, k) return cmp.config.compare[k] end,
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

return compare
