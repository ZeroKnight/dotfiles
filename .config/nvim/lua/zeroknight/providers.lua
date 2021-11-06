-- Neovim Provider Settings and Functions

local Path = require 'plenary.path'
local Job = require 'plenary.job'

local M = {
  venv_root = Path:new(vim.fn.stdpath 'data', 'pynvim-venvs'),
}

local function job_stderr(job)
  return table.concat(job:stderr_result(), '\n')
end

local function venv_maker(version, path)
  if path:exists() then
    error(string.format('Failed to create Python %d provider venv: "%s" already exists', version, tostring(path)))
    return nil
  end

  local opts = {}
  if version == 3 then
    opts.command = 'python3'
    opts.args = { '-m', 'venv', tostring(path) }
  elseif version == 2 then
    opts.command = 'virtualenv'
    opts.args = { '-p', 'python2', tostring(path) }
  else
    error(debug.traceback('Invalid Python version: ' .. version))
  end
  return Job:new(vim.tbl_extend('error', opts, {
    on_exit = function(j, ret)
      if ret ~= 0 then
        error(string.format('Failed to create Python %d provider venv: %s', version, job_stderr(j)))
      end
    end,
  }))
end

function M.create_python_venv(version)
  local ok = false
  local venv = M.get_python_venv(version)

  if not M.venv_root:exists() then
    M.venv_root:mkdir { parents = true }
  end

  local mkvenv = venv_maker(version, venv)
  if mkvenv then
    mkvenv:and_then_on_success(Job:new {
      command = './pip',
      args = { 'install', 'pynvim' },
      cwd = tostring(venv / 'bin'),
      skip_validation = true, -- Necessary since pip doesn't exist yet
      on_exit = function(j, ret)
        if ret == 0 then
          ok = true
          print('Installed pynvim for Python ' .. version .. ' provider')
        else
          error(string.format('Failed to install pynvim for Python %d provider: %s', version, job_stderr(j)))
        end
      end,
    })
    mkvenv:sync()
  end
  return ok
end

function M.get_python_venv(version)
  return M.venv_root:joinpath('py' .. version .. 'nvim')
end

function M.python(version)
  return tostring(M.get_python_venv(version):joinpath('bin/python' .. version))
end

return M
