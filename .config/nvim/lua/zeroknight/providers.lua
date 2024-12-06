-- Neovim Provider Settings and Functions

local Path = require 'plenary.path'

local M = {
  venv_root = Path:new(vim.fn.stdpath 'data', 'pynvim-venvs'),
}

function M.get_python_venv(version) return M.venv_root:joinpath('py' .. version .. 'nvim') end

function M.python(version) return tostring(M.get_python_venv(version):joinpath('bin/python' .. version)) end

return M
