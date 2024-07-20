-- Code linting

local util = require 'zeroknight.util'

local M = {
  -- Primary "global" setting for automatic linting
  auto_lint = true,

  -- Linting handler (no built-in default)
  lint_func = nil,
}

-- Whether automatic linting should be performed. Linting will occur if either
-- the "global" `auto_lint` variable in this module is true, or if a
-- buffer-local version is true. Also, linting will only be performed on
-- "normal" buffers, i.e. non-special or ephemeral ones.
---@param buffer number?
function M.should_lint(buffer)
  buffer = buffer or 0
  return util.is_normal_buffer(buffer) and (vim.b[buffer].auto_lint or M.auto_lint)
end

-- Toggle automatic linting on or off. If toggling on, the buffer-local setting
-- will be overridden if it is enabled, similar to how Vim does things with its
-- own options.
---@param buffer number?
function M.toggle(buffer)
  buffer = buffer or 0
  M.auto_lint = not M.auto_lint
  if M.auto_lint then
    vim.b[buffer].auto_lint = false
    vim.notify('Enabled automatic linting', vim.log.levels.INFO, { title = 'Option toggled' })
  else
    vim.notify('Disabled automatic linting', vim.log.levels.INFO, { title = 'Option toggled' })
  end
end

-- Lint the current buffer. Any arguments are passed to `lint.lint_func` as-is.
---@param ... any
function M.lint(...)
  if M.lint_func == nil then
    vim.notify('zeroknight.lint.lint_func is not set', vim.log.levels.ERROR, { title = 'Linting failed' })
  elseif M.should_lint() then
    M.lint_func(...)
  end
end

return M
