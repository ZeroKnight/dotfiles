-- LSP Formatting

local util = require 'zeroknight.util'

local M = {}

-- Primary "global" setting for automatic formatting
M.format_on_write = true

-- Whether formatting should be done automatically on write.
-- Formatting will occur if either the "global" format_on_write variable in
-- this module is true, or if a buffer-local version is true.
function M.should_format()
  return vim.b.format_on_write or M.format_on_write
end

-- Toggle format on write on or off. If toggling on, the buffer-local setting
-- will be overridden if it is enabled, similar to Vim does things with its
-- own options.
function M.toggle()
  M.format_on_write = not M.format_on_write
  if M.format_on_write then
    vim.b.format_on_write = false
    util.info 'Enabled format on write'
  else
    util.warn 'Disabled format on write'
  end
end

-- Request that the current buffer be formatted by any and all attached Language
-- Servers.
function M.format(force)
  if M.should_format() or force then
    vim.lsp.buf.format()
  end
end

function M.on_attach(client, buffer)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd('BufWritePre', {
      -- Ensure that only one format augroup exists per buffer
      group = vim.api.nvim_create_augroup('ZeroKnight.lsp.format.' .. buffer, { clear = true }),
      buffer = buffer,
      desc = 'Runs formatting on buffer write',
      callback = function()
        if M.should_format() then
          M.format()
        end
      end,
    })
  end
end

return M
