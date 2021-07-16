-- Telescope configuration and utilities
-- Some parts taken/modified from tjdevries's config

local telescope = require('telescope')
local builtin = require('telescope.builtin')

-- Store options used by mappings here so that the tables holding them aren't
-- recreated every time the mapping is executed.
zeroknight.telescope_map_opts = zeroknight.telescope_map_opts or {}

local function map_telescope(lhs, picker, opts, buffer)
  zeroknight.telescope_map_opts[lhs] = opts or {}
  local rhs = string.format(
    "<Cmd>lua require('plugin.telescope')['%s'](zeroknight.telescope_map_opts['%s'])<CR>",
    picker, lhs
  )
  local mapping_opts = {noremap = true, silent = true}

  if not buffer then
    vim.api.nvim_set_keymap('n', lhs, rhs, mapping_opts)
  else
    vim.api.nvim_buf_set_keymap(0, 'n', lhs, rhs, mapping_opts)
  end
end

-- Telescope Mappings
map_telescope('<C-p>',      'buffers')
map_telescope('<Leader>ff', 'find_files')
map_telescope('<Leader>fo', 'oldfiles')
map_telescope('<Leader>fG', 'live_grep')
map_telescope('<Leader>fh', 'help_tags')
map_telescope('<Leader>fm', 'man_pages')
map_telescope('<Leader>f:', 'command_history')
map_telescope('<Leader>f/', 'search_history')
map_telescope('<Leader>ft', 'treesitter')

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
        ['<C-s>'] = 'select_horizontal', ['<C-x>'] = false
      },
      n = {
        ['<C-s>'] = 'select_horizontal', ['<C-x>'] = false
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

-- TODO: custom Telescope pickers, e.g. nvim/zsh config files

return setmetatable({map_telescope = map_telescope}, {
  __index = function(_, k)
    if M[k] then
      return M[k]
    else
      return builtin[k]
    end
  end
})

