-- Assorted utility functions, optionally in global scope

--# selene: allow(global_usage)

-- Namespace for my global variables
_G.zeroknight = _G.zeroknight or {}

-- Return a subpath under a standard path
--- @param what 'cache'|'config'|'config_dirs'|'data'|'data_dirs'|'log'|'run'|'state'
--- @param ... string
--- @return string|string[]
function _G.join_stdpath(what, ...)
  local stdpath = vim.fn.stdpath(what)
  if type(stdpath) == 'table' then
    local args = { ... }
    return vim.tbl_map(function(x) return vim.fs.joinpath(x, unpack(args)) end, stdpath)
  end
  return vim.fs.joinpath(stdpath, ...)
end

-- Lua shorthand for VimL has()
---@param what string
function _G.has(what) return vim.fn.has(what) == 1 end

-- Shorthand for current buffer
---@return string|nil
function _G.currbuf() return vim.uv.fs_realpath(vim.api.nvim_buf_get_name(0)) end

-- Modded from tjdevries
vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('zeroknight.globals', { clear = true }),
  pattern = 'VeryLazy',
  callback = function()
    _G.reload = require('plenary.reload').reload_module
    _G.rerequire = function(name)
      reload(name)
      return require(name)
    end
  end,
})
