-- Coding Plugins
--
-- Plugins that assist with or provide tools for working with, manipulating,
-- or transforming code.

return {
  {
    'klen/nvim-test',
    cmd = { 'TestSuite', 'TestClass', 'TestFile', 'TestNearest', 'TestLast', 'TestVisit' },
    keys = {
      { '<LocalLeader>tt', '<Cmd>TestNearest<CR>', 'Run test nearest to cursor' },
      { '<LocalLeader>tT', '<Cmd>TestClass<CR>', 'Run test class nearest to cursor' },
      { '<LocalLeader>tf', '<Cmd>TestFile<CR>', 'Run all tests in file' },
      { '<LocalLeader>ta', '<Cmd>TestSuite<CR>', 'Run the entire test suite' },
      { '<LocalLeader>tl', '<Cmd>TestLast<CR>', 'Re-run the last test' },
      { '<LocalLeader>tg', '<Cmd>TestVisit<CR>', 'Jump to the file of the last run test' },
      { '<LocalLeader>te', '<Cmd>TestEdit<CR>', 'Edit corresponding test file' },
    },
  },

  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
    },
    opts = {},
    keys = function()
      local function refactor(opts)
        return {
          opts[1],
          string.format([[<Esc><Cmd>lua require('refactoring').refactor('%s')<CR>]], opts[2]),
          desc = opts[2],
          mode = opts.mode or 'n',
        }
      end

      local function debug(opts)
        return {
          opts[1],
          string.format([[<Cmd>lua require('refactoring').debug.%s<CR>]], opts[2]),
          desc = opts.desc,
          mode = opts.mode or 'n',
        }
      end

      return {
        {
          '<Leader>rr',
          [[<Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]],
          desc = 'Select Refactor',
        },

        refactor { '<Leader>rf', 'Extract Function', mode = 'v' },
        refactor { '<Leader>rF', 'Extract Function To File', mode = 'v' },
        refactor { '<Leader>rv', 'Extract Variable', mode = 'v' },
        refactor { '<Leader>rV', 'Inline Variable', mode = 'v' },
        refactor { '<Leader>rV', 'Inline Variable' },
        refactor { '<Leader>rb', 'Extract Block' },
        refactor { '<Leader>rB', 'Extract Block To File' },

        debug { '<Leader>rpv', 'print_var({ normal = true })', desc = 'Debug: Print variable' },
        debug { '<Leader>rpv', 'print_var({})', desc = 'Debug: Print variable', mode = 'v' },
        debug { '<Leader>rpc', 'printf({ below = false })', desc = 'Debug: Print function call' },
        debug { '<Leader>rpx', 'cleanup({})', desc = 'Remove debug prints' },
      }
    end,
    config = function(_, opts)
      require('refactoring').setup(opts)
      require('telescope').load_extension 'refactoring'
      require('which-key').register({
        ['<Leader>rp'] = { name = 'Print-Debugging' },
      }, { mode = { 'n', 'v' } })
    end,
  },
}
