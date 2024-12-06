-- Custom Telescope actions

local M = {}

function M.open_in_file_browser(prompt_bufnr)
  local entry = require('telescope.actions.state').get_selected_entry()
  local dir = require('telescope.from_entry').path(entry)
  if vim.fn.isdirectory(dir) == 1 then
    require('telescope.actions').close(prompt_bufnr)
    require('telescope.extensions').file_browser.file_browser { cwd = dir }
  else
    vim.notify('Not a directory: ' .. dir, vim.log.levels.INFO)
  end
end

-- Wrapping this so that it shows up in Telescope's which-key properly
function M.open_with_trouble(prompt_bufnr) require('trouble.sources.telescope').open(prompt_bufnr) end

-- NOTE: The builtin find_files doesn't expose its unique options in its state,
-- so to toggle things like hidden and ignored files, we have to re-run it.

function M.fd_toggle_hidden(prompt_bufnr)
  local p = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  require('telescope.builtin').find_files { cwd = p.cwd, hidden = true }
end

function M.fd_toggle_ignore(prompt_bufnr)
  local p = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  require('telescope.builtin').find_files { cwd = p.cwd, no_ignore = true }
end

return M
