-- Various utility stuff

local M = {}

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
  return vim.call('system', string.format('%s -c %s', interpreter, ver_cmd))
end

return M
