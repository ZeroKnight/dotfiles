-- Telescope configuration and utilities
-- Some parts taken/modified from tjdevries's config

-- Reminder: Pickers determine *what* you're finding, Finders *get* what you're
-- picking, and Sorters *order* what the Finder found.

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local from_entry = require('telescope.from_entry')
local themes = require('telescope.themes')
local extensions = telescope.extensions

local trouble = require("trouble.providers.telescope")

local util = require('zeroknight.util')

local M = {}

-- Store a map of keymaps to a partial function that calls a picker with specific options.
-- This way, the picker options tables aren't rebuilt every time the mapping is used.
zeroknight.telescope_mapped_pickers = zeroknight.telescope_mapped_pickers or {}

-- Create a mapping that opens Telescope in some fashion. Picker options, if
-- given, are cached for the given mapping.
function M.map_telescope(lhs, opts)
  local picker
  if type(opts) ~= 'table' then
    opts = {picker = opts}
  elseif opts.picker == nil then
    opts.picker = opts[1]
  end
  if type(opts.picker) == 'function' then
    picker = opts.picker
  elseif type(opts.picker) == 'string' then
    local a, b = unpack(vim.split(opts.picker, '.', true))
    if b ~= nil then
      picker = extensions[a][b]
    else
      picker = M[a] or builtin[a]
    end
  else
    util.error('Unsupported type for opts.picker: ', type(opts.picker))
    return
  end

  local key = util.t(lhs)
  local rhs = string.format('<Cmd>lua zeroknight.telescope_mapped_pickers[%q]()<CR>', key)
  local mode = opts.mode or 'n'
  local mapping_opts = {noremap = true, silent = true}
  zeroknight.telescope_mapped_pickers[key] = util.partial(picker, opts.opts)
  if not opts.buffer then
    vim.api.nvim_set_keymap(mode, lhs, rhs, mapping_opts)
  else
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, mapping_opts)
  end
end
local map_telescope = M.map_telescope

local function open_in_file_browser(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local dir = from_entry.path(entry)
  if vim.fn.isdirectory(dir) == 1 then
    actions.close(prompt_bufnr)
    builtin.file_browser{cwd = dir}
  else
    util.msg('Not a directory: ', dir)
  end
end

-- Telescope Mappings
map_telescope('<C-p>',      {'buffers', opts = {sort_mru = true}})
map_telescope('<Leader>F',  'file_browser')
map_telescope('<Leader>ff', 'find_files')
map_telescope('<Leader>fo', 'oldfiles')
map_telescope('<Leader>fz', 'z')

map_telescope('<Leader><Leader>nc', 'nvim_config')
map_telescope('<Leader><Leader>np', 'nvim_plugins')
map_telescope('<Leader><Leader>zc', 'zsh_config')
map_telescope('<Leader><Leader>p',  'projects')

map_telescope('<F1>',       'help_tags')
map_telescope('<F3>',       'resume')
map_telescope('<Leader>hh', 'help_tags')
map_telescope('<Leader>hm', 'man_pages')
map_telescope('<Leader>hk', 'keymaps')
map_telescope('<Leader>hc', 'commands')
map_telescope('<Leader>hf', 'filetypes')
map_telescope('<Leader>ha', 'autocommands')
map_telescope('<Leader>ho', 'vim_options')
map_telescope('<Leader>hp', 'packer.plugins')

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
map_telescope('<Leader>fgS', 'git_stash')
map_telescope('<Leader>fgi', 'gh.issues')
map_telescope('<Leader>fgp', 'gh.pull_request')
map_telescope('<Leader>fgg', 'gh.gist')
map_telescope('<Leader>fgw', 'gh.run')

map_telescope('<C-l>', {'ultisnips.ultisnips', opts = themes.get_ivy(), mode = 'i'})

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
        ['<C-x>'] = trouble.smart_open_with_trouble,
        ['<C-b>'] = open_in_file_browser,
        ["<C-Down>"] = actions.cycle_history_next,
        ["<C-Up>"] = actions.cycle_history_prev,
      },
      n = {
        ['<C-s>'] = 'select_horizontal',
        ['<C-x>'] = trouble.smart_open_with_trouble,
        ['<C-b>'] = open_in_file_browser,
        ["<C-Down>"] = actions.cycle_history_next,
        ["<C-Up>"] = actions.cycle_history_prev,
      }
    }
  },
  pickers = {
    buffers = {
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
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  },
}

-- Pick from neovim configuration files
function M.nvim_config()
  builtin.find_files {
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
  builtin.find_files {
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
  builtin.find_files {
    prompt_title = 'Zsh Configuration',
    cwd = vim.fn.expand('$ZSH'),
    layout_strategy = 'flex'
  }
end

-- Browse ~/Projects
function M.projects()
  builtin.file_browser {
    prompt_title = 'Projects',
    cwd = '~/Projects'
  }
end

-- Pick a directory from z.lua
function M.z()
  extensions.z.list {
    cmd = {vim.o.shell, '-c', string.format('%s %s -l', vim.env.ZLUA_LUAEXE, vim.env.ZLUA_SCRIPT)},
  }
end

return setmetatable({}, {
    __index = function(_, k)
      if M[k] then
        return M[k]
      else
        return builtin[k]
      end
    end
  }
)

