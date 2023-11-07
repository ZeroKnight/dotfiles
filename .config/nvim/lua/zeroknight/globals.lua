-- Assorted utility functions, optionally in global scope

--# selene: allow(global_usage)

-- Namespace for my global variables
_G.zeroknight = _G.zeroknight or {}

-- Convenient shortcut for printing lua objects
function _G.dump(...)
  print(table.concat(vim.tbl_map(vim.inspect, { ... }), '\n'))
  return ...
end

-- Return a subpath under a standard path
--- @param what 'cache'|'config'|'config_dirs'|'data'|'data_dirs'|'log'|'run'|'state'
--- @param path string
--- @return string|string[]
function _G.as_stdpath(what, path)
  local stdpath = vim.fn.stdpath(what)
  if type(stdpath) == 'table' then
    return vim.tbl_map(function(x)
      return string.format('%s/%s', x, path)
    end, stdpath)
  end
  return string.format('%s/%s', stdpath, path)
end

-- Lua shorthand for VimL has()
---@param what string
function _G.has(what)
  return vim.fn.has(what) == 1
end

-- Shorthand for current buffer
---@return string|nil
function _G.currbuf()
  return vim.uv.fs_realpath(vim.api.nvim_buf_get_name(0))
end

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
