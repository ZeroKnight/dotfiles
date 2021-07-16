-- Assorted utility functions, optionally in global scope

-- Namespace for my global variables
zeroknight = {}

-- Convenient shortcut for printing lua objects
function dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

-- Return a subpath under a standard path
function as_stdpath(what, path)
  return string.format('%s/%s', vim.fn.stdpath(what), path)
end

-- Lua shorthand for VimL has()
function has(what)
  return vim.fn.has(what) == 1
end

-- Modded from tjdevries
if pcall(require, "plenary") then
  reload = require("plenary.reload").reload_module

  rerequire = function(name)
    reload(name)
    return require(name)
  end
end
