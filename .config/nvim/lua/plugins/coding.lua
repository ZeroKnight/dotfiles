-- Coding Plugins
--
-- Plugins that assist with or provide tools for manipulating, analyzing,
-- linting, formatting, or transforming code.

local util = require 'zeroknight.util'

---@type LazySpec
return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      linters_by_ft = {
        gitcommit = { 'gitlint' },
        markdown = { 'markdownlint' },
        rst = { 'rstcheck' },
        sh = { 'shellcheck' },
        vim = { 'vint' },
      },
    },
    config = function(_, opts)
      local lint = require 'lint'
      local linters = lint.linters

      require('zeroknight.lint').lint_func = lint.try_lint
      lint.linters_by_ft = opts.linters_by_ft
      linters.gitlint.stdin = true
      linters.gitlint.args = {
        '--staged',
        '--msg-filename',
        '-',
        '--contrib',
        'contrib-title-conventional-commits',
      }

      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
        group = vim.api.nvim_create_augroup('ZeroKnight.lint', { clear = true }),
        desc = 'Run linters',
        callback = function()
          require('zeroknight.lint').lint()
        end,
      })
    end,
  },

  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = { 'ConformInfo' },
    opts = {
      formatters = {
        trim_newlines = {
          condition = function(self, ctx)
            return not util.is_filetype(ctx.buf, { 'diff', 'gitcommit' })
          end,
        },
        trim_whitespace = {
          condition = function(self, ctx)
            return not util.is_filetype(ctx.buf, { 'diff' })
          end,
        },
      },
      formatters_by_ft = {
        -- Run on all filetypes
        ['*'] = { 'injected' },

        -- Run on all filetypes that don't have any formatters specified
        ['_'] = { 'trim_newlines', 'trim_whitespace' },

        json = { 'jq' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        python = { 'ruff_format', 'ruff_fix' },
        toml = { 'taplo' },
      },
    },
    init = function()
      local format = require 'zeroknight.format'

      -- Hook into my formatting module
      format.format_opts.lsp_fallback = 'always'
      format.format_func = function()
        -- One-time wrapper to support lazy-loading on keymap defined elsewhere
        format.format_func = require('conform').format
        format.format()
      end

      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  {
    'klen/nvim-test',
    cmd = { 'TestSuite', 'TestClass', 'TestFile', 'TestNearest', 'TestLast', 'TestVisit' },
    keys = {
      { '<LocalLeader>tt', '<Cmd>TestNearest<CR>', desc = 'Run test nearest to cursor' },
      { '<LocalLeader>tT', '<Cmd>TestClass<CR>', desc = 'Run test class nearest to cursor' },
      { '<LocalLeader>tf', '<Cmd>TestFile<CR>', desc = 'Run all tests in file' },
      { '<LocalLeader>ta', '<Cmd>TestSuite<CR>', desc = 'Run the entire test suite' },
      { '<LocalLeader>tl', '<Cmd>TestLast<CR>', desc = 'Re-run the last test' },
      { '<LocalLeader>tg', '<Cmd>TestVisit<CR>', desc = 'Jump to the file of the last run test' },
      { '<LocalLeader>te', '<Cmd>TestEdit<CR>', desc = 'Edit corresponding test file' },
    },
    config = true,
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
      require('which-key').add {
        { '<Leader>rp', group = 'Print-Debugging', mode = { 'n', 'v' } },
      }
    end,
  },
}
