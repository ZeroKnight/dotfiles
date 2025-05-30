-- Various utility stuff

local format = string.format

local M = {}

_G.zeroknight.lsp_allow_attach = _G.zeroknight.lsp_allow_attach or true
M.root_patterns = { '.git', '' }

-- Returns the module name of the calling function at the given level
---@param level number
---@return string?
function M.get_module_name(level)
  if level == nil then
    level = 2
  end
  ---@type string
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

-- Shorthand for calling `vim.api.nvim_replace_termcodes(key, true, true, true)`
---@param key string
function M.t(key) return vim.api.nvim_replace_termcodes(key, true, true, true) end

-- Call `vim.cmd` as if it were `string.format`. Equivalent to:
-- ```
-- vim.cmd(string.format(cmd, ...))
-- ```
---@param cmd string
function M.cmdf(cmd, ...) vim.cmd(format(cmd, ...)) end

-- Capitalize the first letter of a string
---@param str string
---@return string
function M.capitalize(str) return format('%s%s', string.upper(str:sub(1, 1)), string.lower(str:sub(2))) end

-- Create a partial function
---@param func function
---@param ... any
---@return function
function M.partial(func, ...)
  if func == nil then
    error('cannot make partial function out of nil', 2)
  end
  local frozen_args = { ... }
  return function(...) return func(unpack(frozen_args), ...) end
end

-- Return the path to the current Python interpreter
---@return string
function M.python_interpreter()
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. '/bin/python'
  else
    return vim.fn.exepath 'python3'
  end
end

-- Return the version of the given Python interpreter. If `interpreter` is
-- `nil`, then the current interpreter is queried.
---@param interpreter string?
function M.python_version(interpreter)
  if interpreter == nil then
    interpreter = M.python_interpreter()
  end
  local ver_cmd = vim.fn.shellescape [[import sys; print('.'.join(map(str, sys.version_info[:2])), end='')]]
  return vim.fn.system(format('%s -c %s', interpreter, ver_cmd))
end

-- Toggle the `background` vim option
function M.toggle_background()
  if vim.o.background == 'light' then
    vim.o.background = 'dark'
  else
    vim.o.background = 'light'
  end
end

-- Trim trailing whitespace in buffer while preserving state/position. Acts on
-- the current buffer if `buffer` is `nil`.
---@param buffer number?
function M.trim_whitespace(buffer)
  buffer = buffer or 0
  local trimmed = vim.tbl_map(
    function(x) return x:gsub('%s+$', '') end,
    vim.api.nvim_buf_get_lines(buffer, 0, -1, true)
  )
  vim.api.nvim_buf_set_lines(buffer, 0, -1, true, trimmed)
end

-- From LazyVim. Returns the root directory based on:
-- * LSP workspace folders
-- * LSP `root_dir`
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= '' and vim.uv.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_clients { bufnr = 0 }) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws) return vim.uri_to_fname(ws.uri) end, workspace)
          or client.config.root_dir and { client.config.root_dir }
          or {}
      for _, p in ipairs(paths) do
        local r = vim.uv.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b) return #a > #b end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.uv.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.uv.cwd()
  end
  ---@cast root string
  return root
end

-- Pinched from LazyVim. Check if `plugin` is available.
---@param plugin string
function M.has_plugin(plugin) return require('lazy.core.config').plugins[plugin] ~= nil end

-- Get options for a `LazyPlugin`.
---@param plugin LazyPlugin
function M.plugin_opts(plugin) return require('lazy.core.plugin').values(plugin, 'opts', false) end

-- Add an LspAttach callback
---@param on_attach fun(client: vim.lsp.Client, buffer: number)
---@param desc string?
function M.on_attach(on_attach, desc)
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('ZeroKnight.lsp', { clear = false }),
    desc = desc,
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client == nil then
        error 'client is somehow nil in LspAttach callback'
      end
      if vim.b.lsp_allow_attach or _G.zeroknight.lsp_allow_attach then
        on_attach(client, buffer)
      end
    end,
  })
end

-- Update language server configuration for a specific language server.
-- Sends a `workspace/didChangeConfiguration` notification to running servers
-- and updates the static configuration in `vim.lsp.config`.
---@param server string
---@param config vim.lsp.Config
function M.update_ls_config(server, config)
  vim.validate('server', server, 'string')
  vim.validate('settings', config, 'table')
  vim.lsp.config(server, config)
  for _, client in ipairs(vim.lsp.get_clients { name = server }) do
    client:notify(vim.lsp.protocol.Methods.workspace_didChangeConfiguration, { settings = config.settings })
  end
end

-- Returns a function that calls a telescope picker with specific options.
-- Will find my custom pickers, extensions, and builtin pickers. Also defaults
-- `cwd` to the result of `util.get_root`.
---@param picker string
---@param opts table?
---@return fun()
function M.telescope(picker, opts)
  return function()
    local _opts = vim.tbl_deep_extend('keep', opts or {}, { cwd = M.get_root() })
    require('plugins.telescope.picker')[picker](_opts)
  end
end

-- Returns `true` if buffer is a normal buffer, i.e. not "special" in some way.
-- See `:h special-buffers` for details.
---@param buffer number?
function M.is_normal_buffer(buffer)
  buffer = buffer or 0
  return vim.bo[buffer].buftype == '' and vim.bo[buffer].buflisted
end

-- Check if `buffer` is any of the given filetype(s)
---@param buffer number
---@param filetypes table|string
function M.is_filetype(buffer, filetypes)
  if type(filetypes) == 'string' then
    filetypes = { filetypes }
  end
  return vim.iter(filetypes):any(function(ft) return vim.bo[buffer].filetype == ft end)
end

-- Check if a flag-style custom/plugin option is set, e.g. a plugin feature
-- that can be disabled globally or per buffer, with the buffer scope
-- taking precedence.
---@param name string
---@param buffer number?
function M.flag(name, buffer) return vim.b[buffer or 0][name] ~= false and vim.g[name] ~= false end

return M
