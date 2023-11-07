-- Initial Neovim setup
-- Idea yoinked from tjdevries :)

local util = require 'zeroknight.util'

local format = string.format

local lazy_path = format('%s/lazy/lazy.nvim', vim.fn.stdpath 'data')

local function has_lazy()
  if vim.uv.fs_stat(lazy_path) then
    return true
  end
  util.warn 'Cannot load config until Lazy.nvim is set up. Run ansible!'
  return false
end

local function ensure_state_dirs()
  for _, dir in ipairs { 'shada', 'swap', 'undo', 'view', 'session' } do
    local path = format('%s/%s', vim.fn.stdpath 'state', dir)
    if not vim.uv.fs_stat(path) then
      util.msg('Creating state directory: ', dir)
      vim.fn.mkdir(path, 'p')
    end
  end
end

return function()
  if not has_lazy() then
    return false
  end
  vim.opt.runtimepath:prepend(lazy_path)
  ensure_state_dirs()
  return true
end
