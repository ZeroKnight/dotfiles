-- Utilities for working with keys and mappings

local M = {}

-- Storage for anonymous functions used in mappings
zeroknight.keymap_functions = zeroknight.keymap_functions or {}

-- These mapping functions are taken and slightly modified from folke's dotfiles

function M.execute(key)
  local func = zeroknight.keymap_functions[key]
  if not func then
    error('No function for mapping: ' .. key)
  end
  return func()
end

local map = function(mode, key, cmd, opts, defaults)
  opts = vim.tbl_deep_extend('force', { silent = true }, defaults or {}, opts or {})
  local key_raw = vim.api.nvim_replace_termcodes(key, true, true, true)

  if type(cmd) == 'function' then
    local func_key = string.format('%s_%s', mode, key_raw)
    zeroknight.keymap_functions[func_key] = cmd
    if opts.expr then
      cmd = ([[luaeval('require("zeroknight.util.key").execute(%q)')]]):format(func_key)
    else
      cmd = ("<Cmd>lua require('zeroknight.util.key').execute(%q)<CR>"):format(func_key)
    end
  end
  if opts.buffer ~= nil then
    local buffer = opts.buffer
    opts.buffer = nil
    return vim.api.nvim_buf_set_keymap(buffer, mode, key, cmd, opts)
  else
    return vim.api.nvim_set_keymap(mode, key, cmd, opts)
  end
end

function M.map(mode, key, cmd, opt, defaults)
  return map(mode, key, cmd, opt, defaults)
end

function M.nmap(key, cmd, opts)
  return map('n', key, cmd, opts)
end
function M.vmap(key, cmd, opts)
  return map('v', key, cmd, opts)
end
function M.xmap(key, cmd, opts)
  return map('x', key, cmd, opts)
end
function M.imap(key, cmd, opts)
  return map('i', key, cmd, opts)
end
function M.omap(key, cmd, opts)
  return map('o', key, cmd, opts)
end
function M.smap(key, cmd, opts)
  return map('s', key, cmd, opts)
end

function M.noremap(mode, key, cmd, opts)
  return map(mode, key, cmd, opts, { noremap = true })
end
function M.nnoremap(key, cmd, opts)
  return map('n', key, cmd, opts, { noremap = true })
end
function M.vnoremap(key, cmd, opts)
  return map('v', key, cmd, opts, { noremap = true })
end
function M.xnoremap(key, cmd, opts)
  return map('x', key, cmd, opts, { noremap = true })
end
function M.inoremap(key, cmd, opts)
  return map('i', key, cmd, opts, { noremap = true })
end
function M.onoremap(key, cmd, opts)
  return map('o', key, cmd, opts, { noremap = true })
end
function M.snoremap(key, cmd, opts)
  return map('s', key, cmd, opts, { noremap = true })
end

return M
