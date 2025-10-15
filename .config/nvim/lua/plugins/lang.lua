-- Language Support
--
-- Any plugins that add filetype support or various features, tools, helpers,
-- etc. for any languages.

local util = require 'zeroknight.util'

local wanted_ts_parsers = {
  vendored = {
    -- These ship with Neovim and *should* always be available anyway. Including them for completeness.
    'c',
    'lua',
    'vim',
    'vimdoc',
  },
  langs = {
    -- Languages that I use often; not shipped with Neovim
    'bash',
    'cpp',
    'jq',
    'python',
  },
  docs = {
    -- Documentation and other markup
    'markdown',
    'markdown_inline',
    'rst',
  },
  data = {
    -- Data formats, serialization, configuration, etc.
    'cmake',
    'dockerfile',
    'gitattributes',
    'json',
    'jsonc',
    'make',
    'toml',
    'yaml',
  },
  meta = {
    -- Language constructs, meta-languages, extra syntax, etc.
    'comment',
    'diff',
    'git_rebase',
    'gitcommit',
    'query',
    'regex',
  },
}

---@type LazySpec
return {
  { 'cespare/vim-toml', ft = 'toml' },

  {
    'mfussenegger/nvim-ansible',
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'ansible',
        group = vim.api.nvim_create_augroup('ZeroKnight.plugins.lang.nvim-ansible', { clear = true }),
        desc = 'Create nvim-ansible mappings',
        callback = function()
          vim.keymap.set('n', '<Leader>x', function()
            vim.cmd.write()
            require('ansible').run()
          end, { buffer = true, desc = 'Write and execute the current ansible playbook/role' })
          vim.keymap.set(
            'v',
            '<LocalLeader>x',
            function() require('ansible').run() end,
            { buffer = true, desc = 'Run ansible playbook/role selection' }
          )
        end,
      })
    end,
  },

  -- Web
  { 'mitsuhiko/vim-jinja', ft = { 'html', 'jinja' } },
  -- TODO: revisit this after trying an HTML language server,
  { 'mattn/emmet-vim', ft = { 'html', 'xhtml', 'xml', 'jinja' } },

  -- Misc
  { 'withgod/vim-sourcepawn', ft = 'sourcepawn', enabled = false },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    opts = {
      install_dir = join_stdpath('data', 'treesitter'),
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter.setup', {}),
        desc = 'Set up Treesitter-powered functionality for buffer',
        callback = function(args)
          local buf = args.buf
          local ft = args.match
          local lang = vim.treesitter.language.get_lang(ft) or ft

          if not vim.treesitter.language.add(lang) then
            return
          end

          vim.wo.foldmethod = 'expr'
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          if not vim.tbl_contains({ 'python' }, ft) then
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end

          vim.treesitter.start()
        end,
      })
    end,
    config = function(_, opts)
      local nvim_treesitter = require 'nvim-treesitter'
      nvim_treesitter.setup(opts)
      nvim_treesitter.install(vim.iter(vim.tbl_values(wanted_ts_parsers)):flatten():totable())
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      select = {
        enable = true,
        lookahead = true, -- Jump ahead to next-nearest text-object if needed
        selection_modes = {
          ['@block.inner'] = 'V',
          ['@class.inner'] = 'V',
          ['@function.inner'] = 'V',
          ['@loop.inner'] = 'V',
        },
      },
      move = {
        set_jumps = true,
      },
    },
    keys = {
      {
        ']a',
        function() require('nvim-treesitter-textobjects.swap').swap_next '@parameter.inner' end,
        desc = 'Swap argument with next',
      },
      {
        '[a',
        function() require('nvim-treesitter-textobjects.swap').swap_previous '@parameter.inner' end,
        desc = 'Swap argument with previous',
      },
      {
        ']f',
        function() require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects') end,
        desc = 'Next function start',
      },
      {
        ']]',
        function() require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects') end,
        desc = 'Next class start',
      },
      {
        ']F',
        function() require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects') end,
        desc = 'Next function end',
      },
      {
        '][',
        function() require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects') end,
        desc = 'Next class end',
      },
      {
        '[f',
        function() require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects') end,
        desc = 'Previous function start',
      },
      {
        '[[',
        function() require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects') end,
        desc = 'Previous class start',
      },
      {
        '[F',
        function() require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects') end,
        desc = 'Previous function end',
      },
      {
        '[]',
        function() require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects') end,
        desc = 'Previous class end',
      },
    },
  },

  -- FIXME: Temporary stop-gap for now. Maybe try out the new
  -- vim.lsp.buf.selection_range in 0.12, which is similar
  {
    'MeanderingProgrammer/treesitter-modules.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ---@module 'treesitter-modules'
    ---@type ts.mod.UserConfig
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-Space>',
          node_incremental = '<C-Space>',
          node_decremental = '<BS>',
          scope_incremental = '<C-s>',
        },
      },
    },
  },

  -- TODO: Reimplement context-commentstring

  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      enable = true,
      max_lines = 3,
      trim_scope = 'outer',
      min_window_height = 10,
    },
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    ft = 'markdown',
    opts = {
      completions = { lsp = { enabled = true } },
      on = {
        render = function() vim.diagnostic.enable(false, { bufnr = 0 }) end,
        clear = function() vim.diagnostic.enable(true, { bufnr = 0 }) end,
      },
      overrides = {
        -- Don't auto-activate on `nofile` buffers to avoid breaking plugins
        buftype = { nofile = { enabled = false } },
      },
    },
  },

  {
    'TheLeoP/powershell.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    opts = function()
      local config = vim.lsp.config.powershell_es
      return { ---@type powershell.user_config
        bundle_path = require('mason-core.installer.InstallLocation').global():package 'powershell-editor-services',
        capabilities = config.capabilities,
        settings = config.settings,
        root_dir = function(buf)
          return vim.fs.root(buf, config.root_markers) or vim.fs.dirname(vim.api.nvim_buf_get_name(buf))
        end,
      }
    end,
  },
}
