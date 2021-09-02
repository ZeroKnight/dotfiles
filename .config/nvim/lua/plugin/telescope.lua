-- Telescope configuration and utilities
-- Some parts taken/modified from tjdevries's config

-- Reminder: Pickers determine *what* you're finding, Finders *get* what you're
-- picking, and Sorters *order* what the Finder found.

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

local trouble = require("trouble.providers.telescope")

-- Store options used by mappings here so that the tables holding them aren't
-- recreated every time the mapping is executed.
zeroknight.telescope_map_opts = zeroknight.telescope_map_opts or {}

local mapping_opts = {noremap = true, silent = true}

local function map_telescope(lhs, picker, opts, buffer)
  local lhs_raw = vim.api.nvim_replace_termcodes(lhs, true, true, true)
  local rhs = string.format(
    "<Cmd>lua require('plugin.telescope')['%s'](zeroknight.telescope_map_opts[%q])<CR>",
    picker, lhs_raw
  )
  zeroknight.telescope_map_opts[lhs_raw] = opts or {}
  if not buffer then
    vim.api.nvim_set_keymap('n', lhs, rhs, mapping_opts)
  else
    vim.api.nvim_buf_set_keymap(0, 'n', lhs, rhs, mapping_opts)
  end
end

-- Telescope Mappings
map_telescope('<C-p>',      'buffers')
map_telescope('<Leader>F',  'file_browser')
map_telescope('<Leader>ff', 'find_files')
map_telescope('<Leader>fo', 'oldfiles')

map_telescope('<Leader><Leader>nc', 'nvim_config')
map_telescope('<Leader><Leader>np', 'nvim_plugins')
map_telescope('<Leader><Leader>zc', 'zsh_config')

map_telescope('<Leader>fh', 'help_tags')
map_telescope('<Leader>fm', 'man_pages')
map_telescope('<Leader>fk', 'keymaps')
map_telescope('<Leader>f:', 'command_history')
map_telescope('<Leader>f/', 'search_history')
map_telescope('<Leader>ft', 'treesitter')
map_telescope('<Leader>fq', 'quickfix')
map_telescope('<Leader>fl', 'loclist')

map_telescope('<Leader>fG', 'live_grep')
map_telescope('<Leader>fw', 'grep_string')
map_telescope('<Leader>fb', 'current_buffer_fuzzy_find')

map_telescope('<Leader>fgf', 'git_files')
map_telescope('<Leader>fgc', 'git_commits')
map_telescope('<Leader>fgC', 'git_bcommits')
map_telescope('<Leader>fgb', 'git_branches')
map_telescope('<Leader>fgs', 'git_status')
map_telescope('<Leader>fgt', 'git_stash')

-- Fuzzy search command history
vim.api.nvim_set_keymap(
  'c', '<C-t>', "getcmdtype() == ':' ? '<Plug>(TelescopeFuzzyCommandSearch)' : '<C-t>'", {expr = true}
)

telescope.setup {
  defaults = {
    prompt_prefix = '🔍 ',
    selection_caret = '❯ ',
    winblend = 13,
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
        ['<C-s>'] = 'select_horizontal',
        ['<C-x>'] = trouble.smart_open_with_trouble
      },
      n = {
        ['<C-s>'] = 'select_horizontal',
        ['<C-x>'] = trouble.smart_open_with_trouble
      }
    }
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ['<M-d>'] = 'delete_buffer'
        },
        n = {
          ['<M-d>'] = 'delete_buffer'
        }
      }
    },
    search_history = {theme = 'dropdown'},
    colorscheme = {theme = 'dropdown'},
    vim_options = {theme = 'dropdown'}
  }
}

local M = {}

-- Pick from neovim configuration files
function M.nvim_config()
  require('telescope.builtin').find_files {
    prompt_title = 'Neovim Configuration',
    cwd = vim.fn.stdpath('config'),
    layout_strategy = 'flex',
    layout_config = {
      horizontal = {
        preview_width = 0.6
      }
    }
  }
end

-- Pick from installed neovim plugins
function M.nvim_plugins()
  require('telescope.builtin').find_files {
    prompt_title = 'Neovim Plugin Files',
    cwd = as_stdpath('data', 'site/pack/packer'),
    layout_strategy = 'horizontal',
    layout_config = {
      preview_width = 0.6
    }
  }
end

-- Pick from Zsh configuration files
function M.zsh_config()
  require('telescope.builtin').find_files {
    prompt_title = 'Zsh Configuration',
    cwd = vim.fn.expand('$ZSH'),
    layout_strategy = 'flex'
  }
end

return setmetatable({map_telescope = map_telescope}, {
  __index = function(_, k)
    if M[k] then
      return M[k]
    else
      return builtin[k]
    end
  end
})

