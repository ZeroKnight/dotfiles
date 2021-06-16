-- Initial Neovim setup
-- Idea yoinked from tjdevries :)

local msg_prefix = '[zeroknight.bootstrap]'

local function msg(...)
  print(msg_prefix, ...)
end

local function warn(...)
  local args = {string.format('%s WARNING: ', msg_prefix), ...}
  vim.api.nvim_echo(
    vim.tbl_map(function(x) return {x, 'WarningMsg'} end, args), true, {}
  )
end

local function err(...)
  error(string.format('%s %s', msg_prefix, table.concat({...}, ' ')))
end

local function download_packer()
  local choice = string.lower(vim.fn.input(msg_prefix .. ' Download Packer? (y/n) ')) 
  vim.cmd('redraw')
  if choice ~= 'y' then
    warn('Cannot load config until Packer is set up.')
    vim.opt.loadplugins = false  -- Don't try to load our incomplete config
    return
  end

  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  local packer_dir = string.format('%s/site/pack/packer/start', vim.fn.stdpath('data'))

  vim.fn.mkdir(packer_dir, 'p')
  msg('Downloading Packer...')
  msg(vim.fn.system(string.format('git clone --depth=1 %s %s/packer.nvim', packer_url, packer_dir)))
  if vim.g.shell_error then
    err(string.format('Error downloading Packer:\n%s', vim.g.shell_error))
  else
    msg('Packer has been downloaded, restart Neovim to complete bootstrap.')
  end
end

-- Set up Neovim state directories
local function make_state_dirs()
  msg('Creating Neovim state directories')
  for _, dir in ipairs{'swap', 'undo', 'view', 'session'} do
    local path = string.format('%s/%s', vim.fn.stdpath('data'), dir)
    vim.fn.mkdir(path, 'p')
  end
end

return function()
  if not pcall(require, 'packer') then
    make_state_dirs()
    download_packer()
    return true
  end

  -- Ensure that we have plenary
  local has_plenary, Path = pcall(require, 'plenary.path')
  if not has_plenary then
    err("Packer is installed, but plenary isn't available.")
    return true
  end

  -- Create Python provider venvs if needed
  local providers = require('zeroknight.providers')
  local python_versions = {3}  -- TODO: For now, I only care about Python3
  for _, version in ipairs(python_versions) do
    if not providers.get_python_venv(version) then
      msg('Creating venv for Python', version, 'Provider')
      if not providers.create_python_venv(version) then
        return true
      end
    end
  end

  return false
end
