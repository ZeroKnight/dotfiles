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

-- Shorthand for current buffer
function _G.currbuf()
  return vim.loop.fs_realpath(vim.api.nvim_buf_get_name(0))
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
