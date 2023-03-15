-- Testing Configuration

local wk = require 'which-key'

vim.g['test#strategy'] = {
  nearest = 'basic',
  class = 'basic',
  file = 'basic',
  suite = 'kitty',
}

vim.g['test#preserve_screen'] = 1

wk.register({
  name = 'testing',
  t = { '<Cmd>TestNearest<CR>', 'Run test nearest to cursor' },
  T = { '<Cmd>TestClass<CR>', 'Run test class nearest to cursor' },
  f = { '<Cmd>TestFile<CR>', 'Run all tests in file' },
  a = { '<Cmd>TestSuite<CR>', 'Run the entire test suite' },
  l = { '<Cmd>TestLast<CR>', 'Re-run the last test' },
  g = { '<Cmd>TestVisit<CR>', 'Jump to the file of the last run test' },
}, {
  prefix = '<Leader>t',
})
