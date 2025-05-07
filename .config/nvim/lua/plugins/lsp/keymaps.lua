-- LSP-related Keymaps

local util = require 'zeroknight.util'
local handlers = require 'plugins.lsp.handlers'

local lsp = vim.lsp

-- Set up primary group names
require('which-key').add {
  mode = { 'n', 'v' },
  { '<LocalLeader>c', group = 'code' },
  { '<LocalLeader>p', group = 'preview/peek' },
}

local M = {}

-- stylua: ignore
M.keys = {
  { 'gr', '<Cmd>Telescope lsp_references<CR>', desc = 'Find References', has = 'references' },
  { 'gd', '<Cmd>Telescope lsp_definitions<CR>', desc = 'Jump to Definition', has = 'definition' },
  { 'gD', lsp.buf.declaration, desc = 'Jump to Declaration', has = 'declaration' },
  { 'gy', '<Cmd>Telescope lsp_type_definitions<CR>', desc = 'Jump to Type Definition', has = 'typeDefinition' },
  { 'gI', '<Cmd>Telescope lsp_implementations<CR>', desc = 'Jump to Implementation', has = 'implementationProvider' },
  { 'K', lsp.buf.hover, desc = 'Show Hover Info', has = 'hover' },
  { '<F2>', lsp.buf.rename, desc = 'Rename Symbol', has = 'rename' },
  { '<C-s>', lsp.buf.signature_help, desc = 'Show Signature Help', mode = 'i', has = 'signatureHelp' },

  { '<LocalLeader>ca', function() require('actions-preview').code_actions() end, desc = 'Code Actions', mode = { 'n', 'v' }, has = 'codeAction' },
  { '<LocalLeader>ci', '<Cmd>Telescope lsp_incoming_calls<CR>', desc = 'Incoming calls', has = 'callHierarchy' },
  { '<LocalLeader>co', '<Cmd>Telescope lsp_outgoing_calls<CR>', desc = 'Outgoing calls', has = 'callHierarchy' },
  { '<LocalLeader>cs', '<Cmd>Telescope lsp_document_symbols<CR>', desc = 'Find Symbol' },
  { '<LocalLeader>cS', '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>', desc = 'Find Symbol (Workspace)' },
  { '<LocalLeader>ch', lsp.buf.typehierarchy, desc = 'Show Type Hierarchy', has = 'prepareTypeHierarchy' },

  { '<LocalLeader>pd', util.partial(handlers.peek, 'definition'), desc = 'Peek Definition', has = 'definition' },
  { '<LocalLeader>pD', util.partial(handlers.peek, 'declaration'), desc = 'Peek Declaration', has = 'declaration' },
}

-- Callback to set LSP-related keymaps.
-- Tweaked from LazyVim.
function M.on_attach(client, buffer)
  local Keys = require 'lazy.core.handler.keys'
  for _, spec in ipairs(M.keys) do
    local keymap = Keys.parse(spec)
    if not keymap.has or client.server_capabilities[keymap.has .. 'Provider'] then
      local opts = Keys.opts(keymap)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keymap.mode or 'n', keymap.lhs, keymap.rhs, opts)
    end
  end
end

return M
