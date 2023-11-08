-- Code formatting

local util = require 'zeroknight.util'

local M = {
  -- Primary "global" setting for automatic formatting
  format_on_write = true,

  -- Formatting handler. Defaults to vim.lsp.buf.format but can be overridden
  -- by plugins.
  format_func = vim.lsp.buf.format,

  -- Default options to call format_func with
  format_opts = { timeout_ms = 1000 },
}

-- Whether formatting should be done automatically on write.
-- Formatting will occur if either the "global" format_on_write variable in
-- this module is true, or if a buffer-local version is true.
function M.should_format()
  return vim.b.format_on_write or M.format_on_write
end

-- Toggle format on write on or off. If toggling on, the buffer-local setting
-- will be overridden if it is enabled, similar to how Vim does things with its
-- own options.
function M.toggle()
  M.format_on_write = not M.format_on_write
  if M.format_on_write then
    vim.b.format_on_write = false
    vim.notify('Enabled format on write', vim.log.levels.INFO, { title = 'Option toggled' })
  else
    vim.notify('Disabled format on write', vim.log.levels.INFO, { title = 'Option toggled' })
  end
end

-- Format the current buffer. `opts` is passed to `format.format_func` and
-- is merged with `format.format_opts`. If `force = true` then do formatting
-- regardless of `should_format`.
---@param opts table?
---@param force boolean?
function M.format(opts, force)
  if M.should_format() or force then
    M.format_func(vim.tbl_extend('force', M.format_opts, opts or {}))
  end
end

return M
