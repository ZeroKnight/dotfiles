-- Various utility stuff

local format = string.format

local M = {}

-- Returns the module name of the calling function
function M.get_module_name()
  local name
  local info = debug.getinfo(4, 'S')
  local filename = string.match(info.source, '^@(.+)$')
  if filename ~= nil then
    name = filename:match('lua/(%S+)%.lua$'):gsub('/', '.'):gsub('%.init$', '')
  else
    name = info.source
  end
  return name
end

function M.log(hl, ...)
  local args = {format('[%s] ', M.get_module_name()), ...}
  vim.api.nvim_echo(
    vim.tbl_map(function(x) return {x, hl} end, args), true, {}
  )
end

function M.msg(...)
  M.log('Normal', ...)
end

function M.info(...)
  M.log('DiagnosticInfo', 'Info: ', ...)
end

function M.warn(...)
  M.log('DiagnosticWarn', 'Warning: ', ...)
end

function M.error(...)
  M.log('DiagnosticError', 'Error: ', ...)
end

function M.t(key)
  return vim.api.nvim_replace_termcodes(key, true, true, true)
end

function M.cmdf(cmd, ...)
  vim.cmd(format(cmd, ...))
end

function M.python_interpreter()
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. '/bin/python'
  else
    return vim.call('exepath', 'python3')
  end
end

function M.python_version(interpreter)
  local ver_cmd = vim.call(
    'shellescape', "import sys; print('.'.join(map(str, sys.version_info[:2])), end='')")
  return vim.call('system', format('%s -c %s', interpreter, ver_cmd))
end

return M
