local ls = require 'luasnip'

local M = {
  bpairs = { ['[[ '] = ' ]]', ['(( '] = ' ))', ['[ '] = ' ]', ['('] = ')' },
}

-- Return a choice node of different shell-script compound types. Pair with
-- `close_compound`.
function M.compound_choice(pos) return ls.c(pos, { ls.t '[[ ', ls.t '[ ', ls.t '(( ', ls.t '(' }) end

-- Return a function node that expands to the closing half of a shell-script
-- compound type. Pair with `compound_choice`.
function M.close_compound(pos)
  return ls.f(function(args) return M.bpairs[args[1][1]] end, pos)
end

return M
