-- Custom Telescope actions

local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local action_utils = require 'telescope.actions.utils'
local builtin = require 'telescope.builtin'
local extensions = require('telescope').extensions
local from_entry = require 'telescope.from_entry'

local M = {}

function M.open_in_file_browser(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local path = from_entry.path(entry)
  if not path then
    return
  end
  if vim.fn.isdirectory(path) ~= 1 then
    path = vim.fs.dirname(path)
  end
  actions.close(prompt_bufnr)
  extensions.file_browser.file_browser { cwd = path }
end

-- Wrapping this so that it shows up in Telescope's which-key properly
function M.open_with_trouble(prompt_bufnr) require('trouble.sources.telescope').open(prompt_bufnr) end

-- NOTE: The builtin find_files doesn't expose its unique options in its state,
-- so to toggle things like hidden and ignored files, we have to re-run it.

function M.fd_toggle_hidden(prompt_bufnr)
  local p = action_state.get_current_picker(prompt_bufnr)
  builtin.find_files { cwd = p.cwd, hidden = true }
end

function M.fd_toggle_ignore(prompt_bufnr)
  local p = action_state.get_current_picker(prompt_bufnr)
  builtin.find_files { cwd = p.cwd, no_ignore = true }
end

local function chdir(_, scope)
  local entry = action_state.get_selected_entry()
  local path = from_entry.path(entry)
  if not path then
    return
  end
  if vim.fn.isdirectory(path) ~= 1 then
    path = vim.fs.dirname(path)
  end

  local chdir_map = {
    global = { text = 'working directory', fn = vim.cmd.cd },
    window = { text = 'window working directory', fn = vim.cmd.lcd },
    tab = { text = 'tab working directory', fn = vim.cmd.tcd },
  }
  local ok, err = pcall(chdir_map[scope].fn, path)
  if ok then
    vim.notify(string.format("Changed %s to '%s'", chdir_map[scope].text, path), vim.log.levels.INFO)
  else
    vim.notify(
      string.format("Failed to change %s to '%s':\n%s", chdir_map[scope].text, path, err),
      vim.log.levels.ERROR
    )
  end
end
function M.change_directory(prompt_bufnr) chdir(prompt_bufnr, 'global') end
function M.change_directory_win(prompt_bufnr) chdir(prompt_bufnr, 'window') end
function M.change_directory_tab(prompt_bufnr) chdir(prompt_bufnr, 'tab') end

return setmetatable(M, {
  __index = function(_, k) return actions[k] end,
})
