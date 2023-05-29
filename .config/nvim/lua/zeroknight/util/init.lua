-- Various utility stuff

local format = string.format

local M = {}

M.root_patterns = { '.git', '' }

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

function M.capitalize(str)
  return format('%s%s', string.upper(str:sub(1, 1)), string.lower(str:sub(2)))
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

---@param buffer number?
function M.toggle_diagnostics(buffer)
  if vim.diagnostic.is_disabled(buffer) then
    vim.diagnostic.enable(buffer)
    vim.notify('Enabled diagnostics', vim.log.levels.INFO, { title = 'Diagnostics' })
  else
    vim.diagnostic.disable(buffer)
    vim.notify('Disabled diagnostics', vim.log.levels.INFO, { title = 'Diagnostics' })
  end
end

-- From LazyVim
-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= '' and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

-- Pinched from LazyVim
---@param plugin string
function M.has_plugin(plugin)
  return require('lazy.core.config').plugins[plugin] ~= nil
end

-- Add an LspAttach callback
---@param on_attach fun(client, buffer)
---@param desc string?
function M.on_attach(on_attach, desc)
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('ZeroKnight.lsp', { clear = false }),
    desc = desc,
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

-- Returns a function that calls a telescope picker with specific options.
-- Will find my custom pickers, extensions, and builtin pickers. Also defaults
-- `cwd` to the result of `util.get_root`.
function M.telescope(picker, opts)
  opts = vim.tbl_deep_extend('keep', opts or {}, { cwd = M.get_root() })
  return function()
    require('plugins.telescope.picker')[picker](opts)
  end
end

return M
