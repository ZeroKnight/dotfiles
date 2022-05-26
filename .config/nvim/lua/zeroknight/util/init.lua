-- Various utility stuff

local format = string.format

local M = {}

-- Returns the module name of the calling function
function M.get_module_name(level)
  if level == nil then
    level = 2
  end
  local name
  local info = debug.getinfo(level, 'S')
  if info ~= nil then
    local filename = string.match(info.source, '^@(.+)$')
    if filename ~= nil then
      name = filename:match 'lua/(%S+)%.lua$'
      if name ~= nil then
        name = name:gsub('/', '.'):gsub('%.init$', '')
      end
    end
  end
  return name
end

function M._log(hl, ...)
  local args = vim.tbl_flatten { ... }
  local mod_name = M.get_module_name(4)
  if mod_name ~= nil and #mod_name > 0 then
    table.insert(args, 1, format('[%s] ', mod_name))
  end
  vim.schedule(function()
    vim.api.nvim_echo(
      vim.tbl_map(function(x)
        return { x, hl }
      end, args),
      true,
      {}
    )
  end)
end

function M.msg(...)
  M._log('Normal', ...)
end

function M.info(...)
  M._log('DiagnosticInfo', 'Info: ', ...)
end

function M.warn(...)
  M._log('DiagnosticWarn', 'Warning: ', ...)
end

function M.error(...)
  local args = { ... }
  table.insert(args, debug.traceback('', 2))
  M._log('DiagnosticError', 'Error: ', args)
end

function M.t(key)
  return vim.api.nvim_replace_termcodes(key, true, true, true)
end

function M.cmdf(cmd, ...)
  vim.cmd(format(cmd, ...))
end

function M.partial(func, ...)
  if func == nil then
    error('cannot make partial function out of nil', 2)
    return
  end
  local frozen_args = { ... }
  return function(...)
    return func(unpack(frozen_args), ...)
  end
end

function M.python_interpreter()
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. '/bin/python'
  else
    return vim.call('exepath', 'python3')
  end
end

function M.python_version(interpreter)
  local ver_cmd = vim.call('shellescape', "import sys; print('.'.join(map(str, sys.version_info[:2])), end='')")
  return vim.call('system', format('%s -c %s', interpreter, ver_cmd))
end

return M
