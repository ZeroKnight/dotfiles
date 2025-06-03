-- Telescope configuration

local util = require 'zeroknight.util'
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
      local actions = require 'plugins.telescope.actions'
      local fb_actions = require('telescope').extensions.file_browser.actions

      -- When using the flex layout with the default picker layout settings,
      -- there is a point where the horizontal preview disappears due to a lack
      -- of columns, but there are still enough that it doesn't switch over to
      -- the vertical layout. Setting `flip_columns` and `horizontal.preview_cutoff`
      -- to the same value makes the transition seamless.
      local flex_threshold = 150

      -- Customize Telescope's keymap help
      local custom_wk = require('telescope.actions.generate').which_key {
        only_show_current_mode = true,
        keybind_width = 10,
      }

      local ret = {
        defaults = {
          prompt_prefix = '   ',
          selection_caret = '❯ ',
          winblend = 13,
          dynamic_preview_title = true,
          preview = {
            highlight_limit = Snacks.config.bigfile.size / 1024 / 1024,
            filesize_limit = Snacks.config.bigfile.size / 1024 / 1024 * 2,
          },
          layout_strategy = 'flex',
          layout_config = {
            flex = {
              flip_columns = flex_threshold,
              horizontal = {
                preview_cutoff = flex_threshold,
              },
            },
          },
          cycle_layout_list = { 'vertical', 'horizontal', 'center' },
          history = { limit = 256, path = as_stdpath('state', 'telescope_history') },
          file_ignore_patterns = {
            '%.luac',
            '%.shada',
            'swap/.*%.sw[pno]',
          },
          mappings = {
            both = {
              ['<M-f>'] = false,
              ['<M-k>'] = false,
              ['<C-f>'] = false,

              ['<C-n>'] = layout.cycle_layout_next,
              ['<C-p>'] = layout.cycle_layout_prev,
              ['<M-n>'] = actions.cycle_previewers_next,
              ['<M-p>'] = actions.cycle_previewers_prev,
              ['<Down>'] = actions.cycle_history_next,
              ['<Up>'] = actions.cycle_history_prev,

              ['<C-l>'] = actions.preview_scrolling_right,
              ['<C-h>'] = actions.preview_scrolling_left,

              ['<C-s>'] = actions.select_horizontal,
              ['<C-t>'] = actions.select_tab,
              ['<C-x>'] = actions.open_with_trouble,
              ['<M-b>'] = actions.open_in_file_browser,
              ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
              ['<M-q>'] = actions.smart_add_to_qflist,
              ['<C-o>'] = actions.smart_send_to_loclist + actions.open_loclist,
              ['<M-o>'] = actions.smart_add_to_loclist,
            },
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-Space>'] = actions.complete_tag,

              ['<C-/>'] = custom_wk,
            },
            n = {
              ['<C-k>'] = false,

              ['q'] = actions.close,
              ['c'] = actions.drop_all,
              ['v'] = actions.toggle_all,

              ['p'] = layout.toggle_preview,
              ['L'] = actions.results_scrolling_right,
              ['H'] = actions.results_scrolling_left,

              ['<C-c>c'] = actions.change_directory,
              ['<C-c>l'] = actions.change_directory_win,
              ['<C-c>t'] = actions.change_directory_tab,

              ['?'] = custom_wk,
            },
          },
        },
        pickers = {
          find_files = {
            mappings = {
              i = {
                ['<M-h>'] = actions.fd_toggle_hidden,
                ['<M-i>'] = actions.fd_toggle_ignore,
              },
              n = {
                ['zh'] = actions.fd_toggle_hidden,
                ['zi'] = actions.fd_toggle_ignore,
              },
            },
          },
          buffers = {
            mappings = {
              i = {
                ['<M-d>'] = actions.delete_buffer,
              },
              n = {
                ['<M-d>'] = actions.delete_buffer,
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
          spell_suggest = { theme = 'cursor' },
        },
        extensions = {
          file_browser = {
            theme = 'ivy',
            dir_icon = require('zeroknight.config.ui').icons.common.folder,
            hijack_netrw = true,
            grouped = true,
            prompt_path = true,
            hide_parent_dir = true,
            -- Standard picker options
            initial_mode = 'normal',
            scroll_strategy = 'limit',
            selection_strategy = 'follow',
            mappings = {
              i = {
                ['<M-b>'] = false,
              },
              n = {
                ['g'] = false,
                ['e'] = false,
                ['s'] = false,
                ['t'] = false,
                ['<M-b>'] = false,

                ['h'] = fb_actions.goto_parent_dir,
                ['l'] = actions.select_default,
                ['gh'] = fb_actions.goto_home_dir,

                ['sd'] = fb_actions.sort_by_date,
                ['ss'] = fb_actions.sort_by_size,
                ['v'] = fb_actions.toggle_all,
                ['zh'] = fb_actions.toggle_hidden,
                ['zi'] = fb_actions.toggle_respect_gitignore,
              },
            },
          },
          lazy = {
            mappings = {
              open_in_file_browser = '<M-b>',
              open_in_browser = '<C-b>',
              open_in_terminal = '<M-t>',
              -- Dynamic mapping that goes back to the lazy picker after an action
              open_plugins_picker = '<M-l>',
            },
          },
        },
      }
      local mappings = ret.defaults.mappings
      if mappings.both then
        mappings.i = vim.tbl_extend('error', mappings.i, mappings.both)
        mappings.n = vim.tbl_extend('error', mappings.n, mappings.both)
        mappings.both = nil
      end
      return ret
    end,
    keys = {
      { '<C-p>', util.telescope('buffers', { sort_mru = true, cwd = false }), desc = 'Find Buffer' },
      { '<Leader>F', util.telescope 'file_browser.file_browser', desc = 'Browse Files' },
      { '<Leader>ff', util.telescope 'find_files', desc = 'Find File' },
      { '<Leader>fF', util.telescope('find_files', { cwd = false }), desc = 'Find File (cwd)' },
      { '<Leader>fo', util.telescope('oldfiles', { cwd = false }), desc = 'Find Old File' },
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
  ext.spec('nvim-telescope/telescope-github.nvim', 'gh'),
  ext.spec('benfowler/telescope-luasnip.nvim', 'luasnip'),
  ext.spec('tsakirist/telescope-lazy.nvim', 'lazy'),
  ext.spec('nvim-telescope/telescope-z.nvim', 'z'),
  ext.spec('nvim-telescope/telescope-ui-select.nvim', 'ui-select'),
  ext.spec(
    'nvim-telescope/telescope-fzf-native.nvim',
    'fzf',
    { build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
  ),
}
