-- Initial Neovim setup
-- Idea yoinked from tjdevries :)

local util = require 'zeroknight.util'

local format = string.format

local function download_packer()
  local choice = string.lower(vim.fn.input(format('[%s] Download Packer? (y/n) ', util.get_module_name())))
  vim.cmd 'redraw'
  if choice ~= 'y' then
    util.warn 'Cannot load config until Packer is set up.'
    vim.opt.loadplugins = false -- Don't try to load our incomplete config
    return
  end

  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  local packer_dir = format('%s/site/pack/packer/start', vim.fn.stdpath 'data')

  vim.fn.mkdir(packer_dir, 'p')
  util.msg 'Downloading Packer...'
  util.msg(vim.fn.system(format('git clone --depth=1 %s %s/packer.nvim', packer_url, packer_dir)))
  if vim.g.shell_error then
    util.error(format('Failed to download Packer:\n%s', vim.g.shell_error))
  end
end

-- Set up Neovim state directories
local function make_state_dirs()
  util.msg 'Creating Neovim state directories'
  for _, dir in ipairs { 'swap', 'undo', 'view', 'session' } do
    local path = format('%s/%s', vim.fn.stdpath 'state', dir)
    vim.fn.mkdir(path, 'p')
  end
end

-- Load packer and download/install plugins
local function install_plugins()
  util.msg 'Installing plugins...'
  vim.cmd 'packloadall'
  local has_packer, packer = pcall(require, 'packer')
  if not has_packer then
    util.error 'Cannot install plugins, unable to require packer'
    return
  end
  require 'zeroknight.plugins'
  packer.sync()
end

return function()
  if not pcall(require, 'packer') then
    make_state_dirs()
    download_packer()
    install_plugins()
    util.info 'Restart Neovim after packer sync to complete bootstrap.'
    return true
  end

  -- Ensure that we have plenary
  local has_plenary = pcall(require, 'plenary.path')
  if not has_plenary then
    util.error "Packer is installed, but plenary isn't available."
    return true
  end

  -- Create Python provider venvs if needed
  local providers = require 'zeroknight.providers'
  local python_versions = { 3 } -- TODO: For now, I only care about Python3
  for _, version in ipairs(python_versions) do
    if not providers.get_python_venv(version):exists() then
      util.msg('Creating venv for Python', version, 'Provider')
      if not providers.create_python_venv(version) then
        return true
      end
    end
  end

  return false
end
