-- C filetype settings

local opt = vim.opt
local optl = vim.opt_local

vim.g.c_gnu = 1
vim.g.c_comment_strings = 1

-- Load doxygen syntax
vim.g.load_doxygen_syntax = 1

optl.smartindent = false
optl.cindent = true

-- Swap between header and source
vim.keymap.set('n', '<LocalLeader>a', function()
  local ext, _ = string.gsub(vim.fn.expand '%:e', '^([ch])p*$', { c = 'h', h = 'c' }, 1)
  if ext ~= nil then
    local path = table.concat(opt.path:get(), ',')
    local alt = vim.fn.globpath(path, string.format('%s.%s*', vim.fn.expand '%:t:r', ext), false, true)
    return string.format('<Cmd>e %s<CR>', alt[1])
  end
end, {
  buffer = true,
  expr = true,
})
