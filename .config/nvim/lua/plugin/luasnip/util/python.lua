local ls = require 'luasnip'

local M = {}

-- Return a dynamic node that expands to a docstring summary line placeholder.
function M.docstring_summary(pos, name_pos)
  return ls.d(pos, function(args)
    return ls.sn(nil, ls.i(1, ' TODO: Documentation for ' .. args[1][1]:match '^%w+'))
  end, name_pos)
end

-- Return a function node that closes a docstring according to whether it has
-- a body or not.
function M.close_docstring(pos)
  return ls.f(function(args)
    return #args[1] > 1 and { '', '\t"""' } or '"""'
  end, pos)
end

return M
