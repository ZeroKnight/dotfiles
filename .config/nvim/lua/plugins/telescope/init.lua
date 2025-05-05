-- Telescope configuration

local util = require 'zeroknight.util'
local actions = require 'plugins.telescope.actions'
local ext = require 'plugins.telescope.ext'

---@type LazySpec
return {
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    cmd = 'Telescope',
    init = function()
      vim.api.nvim_create_autocmd({ 'BufAdd', 'VimEnter' }, {
        group = vim.api.nvim_create_augroup('ZeroKnight.telescope', { clear = true }),
        pattern = '*',
        desc = 'Lazy-load Telescope when opening a directory',
        callback = function(event)
          if vim.fn.isdirectory(event.file) == 1 and not package.loaded['telescope'] then
            require('lazy.core.loader').load('telescope.nvim', { event = event.event })
            vim.cmd 'doautocmd telescope-file-browser.nvim BufEnter'
          end
        end,
      })
    end,
    opts = function()
      local telescope = require 'telescope'
      local layout = require 'telescope.actions.layout'

      -- When using the flex layout with the default picker layout settings,
      -- there is a point where the horizontal preview disappears due to a lack
      -- of columns, but there are still enough that it doesn't switch over to
      -- the vertical layout. Setting `flip_columns` and `horizontal.preview_cutoff`
      -- to the same value makes the transition seamless.
      local flex_threshold = 120

      return {
        defaults = {
          prompt_prefix = '  ',
          selection_caret = '❯ ',
          winblend = 13,
          dynamic_preview_title = true,
          layout_strategy = 'flex',
          layout_config = {
            flex = {
              flip_columns = flex_threshold,
              horizontal = {
                preview_cutoff = flex_threshold,
              },
            },
          },
          cycle_layout_list = { 'flex', 'vertical', 'horizontal', 'center' },
          history = { limit = 256, path = as_stdpath('state', 'telescope_history') },
          file_ignore_patterns = {
            '%.luac',
            '%.shada',
            'swap/.*%.sw[pno]',
          },
          mappings = {
            i = {
              ['<C-j>'] = 'move_selection_next',
              ['<C-k>'] = 'move_selection_previous',
              ['<C-n>'] = layout.cycle_layout_next,
              ['<C-p>'] = layout.cycle_layout_prev,
              ['<M-p>'] = layout.toggle_preview,
              ['<C-Down>'] = 'cycle_history_next',
              ['<C-Up>'] = 'cycle_history_prev',

              ['<C-s>'] = 'select_horizontal',
              ['<C-x>'] = actions.open_with_trouble,
              ['<M-b>'] = actions.open_in_file_browser,
            },
            n = {
              ['q'] = 'close',
              ['c'] = 'drop_all',

              ['<C-n>'] = layout.cycle_layout_next,
              ['<C-p>'] = layout.cycle_layout_prev,
              ['<M-p>'] = layout.toggle_preview,
              ['<C-Down>'] = 'cycle_history_next',
              ['<C-Up>'] = 'cycle_history_prev',

              ['<C-s>'] = 'select_horizontal',
              ['<C-x>'] = actions.open_with_trouble,
              ['<M-b>'] = actions.open_in_file_browser,
            },
          },
        },
        pickers = {
          find_files = {
            mappings = {
              i = {
                ['<C-h>'] = actions.fd_toggle_hidden,
                ['<M-i>'] = actions.fd_toggle_ignore,
              },
              n = {
                ['h'] = actions.fd_toggle_hidden,
                ['<M-i>'] = actions.fd_toggle_ignore,
              },
            },
          },
          buffers = {
            mappings = {
              i = {
                ['<M-d>'] = 'delete_buffer',
              },
              n = {
                ['<M-d>'] = 'delete_buffer',
              },
            },
          },
          treesitter = {
            symbol_highlights = {
              ['associated'] = '@constant',
              ['constant'] = '@constant',
              ['field'] = '@variable.member',
              ['function'] = '@function',
              ['import'] = '@keyword.import',
              ['method'] = '@function.method',
              ['parameter'] = '@variable.parameter',
              ['property'] = '@property',
              ['struct'] = 'Struct',
              ['type'] = '@type',
              ['var'] = '@variable',
            },
          },
          search_history = { theme = 'dropdown' },
          colorscheme = { theme = 'dropdown' },
          vim_options = { theme = 'dropdown' },
          filetypes = { theme = 'dropdown' },
        },
        extensions = {
          file_browser = {
            theme = 'ivy',
            dir_icon = require('zeroknight.config.ui').icons.common.folder,
            hijack_netrw = true,
            grouped = true,
            prompt_path = true,
            -- Standard picker options
            initial_mode = 'normal',
            scroll_strategy = 'limit',
            selection_strategy = 'follow',
            mappings = {
              i = {
                ['<C-t>'] = 'select_tab',
                ['<M-w>'] = telescope.extensions.file_browser.actions.change_cwd,
              },
              n = {
                ['g'] = false,
                ['u'] = telescope.extensions.file_browser.actions.goto_parent_dir,
              },
            },
          },
          fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
          },
        },
      }
    end,
    keys = {
      { '<C-p>', util.telescope('buffers', { sort_mru = true, cwd = false }), desc = 'Find Buffer' },
      { '<Leader>F', util.telescope 'file_browser.file_browser', desc = 'Browse Files' },
      { '<Leader>ff', util.telescope 'find_files', desc = 'Find File' },
      { '<Leader>fF', util.telescope('find_files', { cwd = false }), desc = 'Find File (cwd)' },
      { '<Leader>fo', util.telescope 'oldfiles', desc = 'Find Old File' },
      { '<Leader>fO', util.telescope('oldfiles', { only_cwd = true }), desc = 'Find Old File (cwd)' },
      { '<Leader>fz', util.telescope 'z', desc = 'Find Directory via z' },

      { '<Leader>f:', util.telescope 'command_history', desc = 'Command History' },
      { '<Leader>f/', util.telescope 'search_history', desc = 'Search History' },
      { '<Leader>ft', util.telescope 'treesitter', desc = 'Find Treesitter Symbols' },
      { '<Leader>fq', util.telescope 'quickfix', desc = 'Find Quickfix' },
      { '<Leader>fl', util.telescope 'loclist', desc = 'Find Location' },
      { '<Leader>fd', util.telescope 'diagnostics', desc = 'Find Diagnostic' },
      { '<Leader>fp', util.telescope 'lazy.lazy', desc = 'Find Plugin' },

      { '<Leader>fgf', util.telescope 'git_files', desc = 'Find Git File' },
      { '<Leader>fgc', util.telescope 'git_commits', desc = 'Find Commit' },
      { '<Leader>fgC', util.telescope 'git_bcommits', desc = 'Find Commit (Buffer)' },
      { '<Leader>fgb', util.telescope 'git_branches', desc = 'Find Branch' },
      { '<Leader>fgs', util.telescope 'git_status', desc = 'Git Status' },
      { '<Leader>fgS', util.telescope 'git_stash', desc = 'Git Stash' },
      { '<Leader>fgi', util.telescope 'gh.issues', desc = 'Find Issue' },
      { '<Leader>fgp', util.telescope 'gh.pull_request', desc = 'Find Pull Request' },
      { '<Leader>fgg', util.telescope 'gh.gist', desc = 'Find Gist' },
      { '<Leader>fgw', util.telescope 'gh.run', desc = 'Workflow Runs' },

      { '<Leader><Leader>nc', util.telescope 'nvim_config', desc = 'Find Neovim Config File' },
      { '<Leader><Leader>nl', util.telescope 'nvim_logs', desc = 'Find Neovim Log File' },
      { '<Leader><Leader>nr', util.telescope 'nvim_runtime', desc = 'Find Neovim Runtime File' },
      { '<Leader><Leader>zc', util.telescope 'zsh_config', desc = 'Find Zsh Config File' },
      { '<Leader><Leader>p', util.telescope 'projects', desc = 'Browse Projects' },

      { '<F1>', util.telescope 'help_tags', desc = 'Help Pages' },
      { '<F3>', util.telescope 'resume', desc = 'Resume last Telescope Picker' },
      { '<Leader>hh', util.telescope 'help_tags', desc = 'Help Pages' },
      { '<Leader>hm', util.telescope 'man_pages', desc = 'Man Pages' },
      { '<Leader>hk', util.telescope 'keymaps', desc = 'Keymaps' },
      { '<Leader>hc', util.telescope 'commands', desc = 'Commands' },
      { '<Leader>hf', util.telescope 'filetypes', desc = 'Filetypes' },
      { '<Leader>ha', util.telescope 'autocommands', desc = 'AutoCommands' },
      { '<Leader>ho', util.telescope 'vim_options', desc = 'Vim Options' },

      { '<Leader>sg', util.telescope 'live_grep', desc = 'Live Grep' },
      { '<Leader>sG', util.telescope('live_grep', { cwd = false }), desc = 'Live Grep (cwd)' },
      { '<Leader>sw', util.telescope 'grep_string', desc = 'Search Word' },
      { '<Leader>sW', util.telescope('grep_string', { cwd = false }), desc = 'Search Word (cwd)' },
      { '<Leader>sb', util.telescope 'current_buffer_fuzzy_find', desc = 'Search in Buffer' },
      { '<Leader>sj', util.telescope 'jumplist', desc = 'Search Jump List' },
      { '<Leader>st', util.telescope 'tagstack', desc = 'Search Tag Stack' },
      { '<Leader>sn', util.telescope 'notify.notify', desc = 'Search Notifications' },

      { '<M-s>', util.telescope 'snippets', desc = 'Find Snippet', mode = 'i' },
    },
    config = function(_, opts)
      local telescope = require 'telescope'
      telescope.setup(opts)
      vim.iter(ext.to_load):each(telescope.load_extension)
    end,
  },

  -- Extensions
  ext.spec('nvim-telescope/telescope-file-browser.nvim', 'file_browser'),
  ext.spec('nvim-telescope/telescope-fzy-native.nvim', 'fzy_native'),
  ext.spec('nvim-telescope/telescope-github.nvim', 'gh'),
  ext.spec('benfowler/telescope-luasnip.nvim', 'luasnip'),
  ext.spec('tsakirist/telescope-lazy.nvim', 'lazy'),
  ext.spec('nvim-telescope/telescope-z.nvim', 'z'),
}
