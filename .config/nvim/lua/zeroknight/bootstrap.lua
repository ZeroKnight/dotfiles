-- Initial Neovim setup
-- Idea yoinked from tjdevries :)

local util = require 'zeroknight.util'

local format = string.format

local lazy_path = format('%s/lazy/lazy.nvim', vim.fn.stdpath 'data')

local function bootstrap_lazy()
  if vim.loop.fs_stat(lazy_path) then
    return true
  end

  local choice = string.lower(vim.fn.input(format('[%s] Download Lazy.nvim? (y/n) ', util.get_module_name())))
  vim.cmd 'redraw'
  if choice ~= 'y' then
    util.warn 'Cannot load config until Lazy.nvim is set up.'
    return false
  end

  vim.fn.mkdir(lazy_path, 'p')
  util.msg 'Cloning Lazy.nvim...'
  local obj = vim
    .system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazy_path,
    }, { text = true })
    :wait()
  util.msg(obj.stdout)
  if obj.code ~= 0 then
    util.error(format('Failed to clone Lazy.nvim:\n%s', obj.stderr))
    return false
  end
  return true
end

local function ensure_state_dirs()
  for _, dir in ipairs { 'swap', 'undo', 'view', 'session' } do
    local path = format('%s/%s', vim.fn.stdpath 'state', dir)
    if not vim.loop.fs_stat(path) then
      util.msg('Creating state directory: ', dir)
      vim.fn.mkdir(path, 'p')
    end
  end
end

-- Create Python provider venvs
local function ensure_python_provider()
  local providers = require 'zeroknight.providers'
  local python_versions = { 3 }
  for _, version in ipairs(python_versions) do
    if not providers.get_python_venv(version):exists() then
      util.msg('Creating venv for Python', version, 'Provider')
      providers.create_python_venv(version)
    end
  end
end

return function()
  if not pcall(require, 'lazy') then
    if not bootstrap_lazy() then
      return true
    end
    vim.opt.runtimepath:prepend(lazy_path)
  end

  ensure_state_dirs()
  -- FIXME: plenary not available until lazy is started
  -- ensure_python_provider()

  return false
end
