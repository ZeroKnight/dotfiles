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
function _G.as_stdpath(what, path)
  return string.format('%s/%s', vim.fn.stdpath(what), path)
end

-- Lua shorthand for VimL has()
function _G.has(what)
  return vim.fn.has(what) == 1
end

-- Modded from tjdevries
if pcall(require, 'plenary') then
  _G.reload = require('plenary.reload').reload_module

  _G.rerequire = function(name)
    reload(name)
    return require(name)
  end
end
