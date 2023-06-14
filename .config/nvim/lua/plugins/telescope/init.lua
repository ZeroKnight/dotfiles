-- Telescope configuration

-- TODO: Come up with a way to let other plugin specs add a telescope extension

local util = require 'zeroknight.util'

local load_extensions = {}
local function tele_extension(source, name)
  return {
    source,
    lazy = true,
    init = function()
      table.insert(load_extensions, name)
    end,
    dependencies = { 'nvim-telescope/telescope.nvim' },
  }
end

local function open_in_file_browser(prompt_bufnr)
  local entry = require('telescope.actions.state').get_selected_entry()
  local dir = require('telescope.from_entry').path(entry)
  if vim.fn.isdirectory(dir) == 1 then
    require('telescope.actions').close(prompt_bufnr)
    require('telescope.extensions').file_browser.file_browser { cwd = dir }
  else
    require('zeroknight.util').msg('Not a directory: ', dir)
  end
end

return {
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    branch = '0.1.x',
    cmd = 'Telescope',
    opts = {
      defaults = {
        prompt_prefix = '🔍 ',
        selection_caret = '❯ ',
        winblend = 13,
        -- stylua: ignore
        mappings = {
          i = {
            ['<C-j>'] = 'move_selection_next',
            ['<C-k>'] = 'move_selection_previous',
            ['<C-s>'] = 'select_horizontal',
            ['<C-x>'] = function(...) return require('trouble').smart_open_with_trouble(...) end,
            ['<C-b>'] = open_in_file_browser,
            ['<C-Down>'] = function(...) return require('telescope.actions').cycle_history_next(...) end,
            ['<C-Up>'] = function(...) return require('telescope.actions').cycle_history_prev(...) end,
          },
          n = {
            ['q'] = function(...) return require('telescope.actions').close(...) end,
            ['<C-s>'] = 'select_horizontal',
            ['<C-x>'] = function(...) return require('trouble').smart_open_with_trouble(...) end,
            ['<C-b>'] = open_in_file_browser,
            ['<C-Down>'] = function(...) return require('telescope.actions').cycle_history_next(...) end,
            ['<C-Up>'] = function(...) return require('telescope.actions').cycle_history_prev(...) end,
          },
        },
      },
      pickers = {
        find_files = {
          mappings = {
            i = {
              ['<C-h>'] = function()
                require('telescope.builtin').find_files { hidden = true }
              end,
              ['<M-i>'] = function()
                require('telescope.builtin').find_files { no_ignore = true }
              end,
            },
            n = {
              ['<C-h>'] = function()
                require('telescope.builtin').find_files { hidden = true }
              end,
              ['<M-i>'] = function()
                require('telescope.builtin').find_files { no_ignore = true }
              end,
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
        search_history = { theme = 'dropdown' },
        colorscheme = { theme = 'dropdown' },
        vim_options = { theme = 'dropdown' },
      },
      extensions = {
        file_browser = {
          theme = 'ivy',
        },
        fzy_native = {
          override_generic_sorter = true,
          override_file_sorter = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { '<C-p>', util.telescope('buffers', { sort_mru = true }), desc = 'Find Buffer' },
      { '<Leader>F', util.telescope('file_browser.file_browser'), desc = 'Browse Files' },
      { '<Leader>ff', util.telescope('find_files'), desc = 'Find File' },
      { '<Leader>fF', util.telescope('find_files', { cwd = false }), desc = 'Find File (cwd)' },
      { '<Leader>fo', util.telescope('oldfiles'), desc = 'Find Old File' },
      { '<Leader>fO', util.telescope('oldfiles', { only_cwd = true }), desc = 'Find Old File (cwd)' },
      { '<Leader>fz', util.telescope('z'), desc = 'Find Directory via z' },

      { '<Leader>f:', util.telescope('command_history'), desc = 'Command History' },
      { '<Leader>f/', util.telescope('search_history'), desc = 'Search History' },
      { '<Leader>ft', util.telescope('treesitter'), desc = 'Find Treesitter Symbols' },
      { '<Leader>fq', util.telescope('quickfix'), desc = 'Find Quickfix' },
      { '<Leader>fl', util.telescope('loclist'), desc = 'Find Location' },
      { '<Leader>fd', util.telescope('diagnostics'), desc = 'Find Diagnostic' },
      { '<Leader>fp', util.telescope('lazy.lazy'), desc = 'Find Plugin' },

      { '<Leader>fgf', util.telescope('git_files'), desc = 'Find Git File' },
      { '<Leader>fgc', util.telescope('git_commits'), desc = 'Find Commit' },
      { '<Leader>fgC', util.telescope('git_bcommits'), desc = 'Find Commit (Buffer)' },
      { '<Leader>fgb', util.telescope('git_branches'), desc = 'Find Branch' },
      { '<Leader>fgs', util.telescope('git_status'), desc = 'Git Status' },
      { '<Leader>fgS', util.telescope('git_stash'), desc = 'Git Stash' },
      { '<Leader>fgi', util.telescope('gh.issues'), desc = 'Find Issue' },
      { '<Leader>fgp', util.telescope('gh.pull_request'), desc = 'Find Pull Request' },
      { '<Leader>fgg', util.telescope('gh.gist'), desc = 'Find Gist' },
      { '<Leader>fgw', util.telescope('gh.run'), desc = 'Workflow Runs' },

      { '<Leader><Leader>nc', util.telescope('nvim_config'), desc = 'Find Neovim Config File' },
      { '<Leader><Leader>nl', util.telescope('nvim_logs'), desc = 'Find Neovim Log File' },
      { '<Leader><Leader>nr', util.telescope('nvim_runtime'), desc = 'Find Neovim Runtime File' },
      { '<Leader><Leader>zc', util.telescope('zsh_config'), desc = 'Find Zsh Config File' },
      { '<Leader><Leader>p', util.telescope('projects'), desc = 'Browse Projects' },

      { '<F1>', util.telescope('help_tags'), desc = 'Help Pages' },
      { '<F3>', util.telescope('resume'), desc = 'Resume last Telescope Picker' },
      { '<Leader>hh', util.telescope('help_tags'), desc = 'Help Pages' },
      { '<Leader>hm', util.telescope('man_pages'), desc = 'Man Pages' },
      { '<Leader>hk', util.telescope('keymaps'), desc = 'Keymaps' },
      { '<Leader>hc', util.telescope('commands'), desc = 'Commands' },
      { '<Leader>hf', util.telescope('filetypes'), desc = 'Filetypes' },
      { '<Leader>ha', util.telescope('autocommands'), desc = 'AutoCommands' },
      { '<Leader>ho', util.telescope('vim_options'), desc = 'Vim Options' },

      { '<Leader>sg', util.telescope('live_grep'), desc = 'Live Grep' },
      { '<Leader>sG', util.telescope('live_grep', { cwd = false }), desc = 'Live Grep (cwd)' },
      { '<Leader>sw', util.telescope('grep_string'), desc = 'Search Word' },
      { '<Leader>sW', util.telescope('grep_string', { cwd = false }), desc = 'Search Word (cwd)' },
      { '<Leader>sb', util.telescope('current_buffer_fuzzy_find'), desc = 'Search in Buffer' },
      { '<Leader>sj', util.telescope('jumplist'), desc = 'Search Jump List' },
      { '<Leader>sn', util.telescope('notify.notify'), desc = 'Search Notifications' },

      { '<M-s>', util.telescope('snippets'), desc = 'Find Snippet', mode = 'i' },

      { '<C-t>', "getcmdtype() == ':' ? '<Plug>(TelescopeFuzzyCommandSearch)' : '<C-t>'", desc = 'Command History', expr = true, mode = 'c' },
    },
    config = function(_, opts)
      require('telescope').setup(opts)
      require('telescope').load_extension 'notify'
      for _, name in ipairs(load_extensions) do
        require('telescope').load_extension(name)
      end
    end,
  },

  -- Extensions
  tele_extension('nvim-telescope/telescope-file-browser.nvim', 'file_browser'),
  tele_extension('nvim-telescope/telescope-fzy-native.nvim', 'fzy_native'),
  tele_extension('nvim-telescope/telescope-github.nvim', 'gh'),
  tele_extension('benfowler/telescope-luasnip.nvim', 'luasnip'),
  tele_extension('tsakirist/telescope-lazy.nvim', 'lazy'),
  tele_extension('nvim-telescope/telescope-z.nvim', 'z'),
}
