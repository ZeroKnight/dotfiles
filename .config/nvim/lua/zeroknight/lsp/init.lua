-- Language Server Configuration

local lsp = vim.lsp
local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
if not has_lspconfig then
  return
end
local lsp_status = require('lsp-status')
local lsp_kinds = require('zeroknight.lsp.kinds')

local wk = require('which-key')

local function lsp_method(kind, method)
  return string.format('<Cmd>lua vim.lsp.%s.%s()<CR>', kind, method)
end

local lsp_keymap = {
  ['<LocalLeader>'] = {
    c = {
      name = 'code/calls',
      a = {'[LSP] Code Actions'},
      A = {'[LSP] Code Actions (Range)'},
      i = {lsp_method('buf', 'incoming_calls'), '[LSP] Incoming Calls'},
      o = {lsp_method('buf', 'outgoing_calls'), '[LSP] Outgoing Calls'}
    },
    d = {
      name = 'document',
      d = {'[LSP] Document Diagnostics'},
      s = {'[LSP] Document Symbols'}
    },
    r = {
      name = 'restart',
      c = {
        function()
          vim.lsp.stop_client(vim.tbl_values(lsp.buf_get_clients(0)))
          vim.cmd 'e'
        end,
        '[LSP] Restart buffer clients'
      },
      C = {
        function()
          vim.lsp.stop_client(lsp.get_active_clients())
          vim.cmd 'e'
        end,
        '[LSP] Restart ALL clients'
      },
    },
    td = {lsp_method('buf', 'type_definition'), '[LSP] Jump to Type Definition'},
    w = {
      name = 'workspace',
      d = {'[LSP] Workspace Diagnostics'},
      s = {'[LSP] Workspace Symbols'}
    }
  },
  ['['] = {
    name = 'prev',
    d = {lsp_method('diagnostic', 'goto_prev'), '[LSP] Previous Diagnostic'}
  },
  [']'] = {
    name = 'next',
    d = {lsp_method('diagnostic', 'goto_next'), '[LSP] Next Diagnostic'}
  },
  ['<F2>'] = {lsp_method('buf', 'rename'), '[LSP] Rename Symbol'},
  g = {
    name = 'goto',
    d = {lsp_method('buf', 'definition'), '[LSP] Jump to Definition'},
    D = {lsp_method('buf', 'declaration'), '[LSP] Jump to Declaration'},
    I = {lsp_method('buf', 'implementation'), '[LSP] Jump to Implementation'},
    r = {'[LSP] Browse References'}
  },
  K = {lsp_method('buf', 'hover'), '[LSP] Show Hover'},
}

-- Mappings for both NORMAL and INSERT mode
local lsp_keymap_ni = {
  ['<C-s>'] = {lsp_method('buf', 'signature_help'), '[LSP] Signature Help'},
  ['<M-d>'] = {lsp_method('diagnostic', 'show_line_diagnostics'), '[LSP] Show diagnostics for line'}
}

local function lsp_buffer_setup(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local map_telescope = require('plugin.telescope').map_telescope

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  wk.register(lsp_keymap, {buffer = bufnr})
  wk.register(lsp_keymap_ni, {buffer = bufnr, mode = 'n'})
  wk.register(lsp_keymap_ni, {buffer = bufnr, mode = 'i'})

  map_telescope('gr', 'lsp_references', {
    sorting_strategy = 'ascending',
    ignore_filename = true
  }, true)
  map_telescope('<LocalLeader>ca', 'lsp_code_actions',          {sorting_strategy = 'ascending'}, true)
  map_telescope('<LocalLeader>cA', 'lsp_range_code_actions',    {sorting_strategy = 'ascending'}, true)
  map_telescope('<LocalLeader>ds', 'lsp_document_symbols',      {ignore_filename = true}, true)
  map_telescope('<LocalLeader>ws', 'lsp_workspace_symbols',     {ignore_filename = true}, true)
  map_telescope('<LocalLeader>dd', 'lsp_document_diagnostics',  nil, true)
  map_telescope('<LocalLeader>wd', 'lsp_workspace_diagnostics', nil, true)

  -- TODO: Make signature help show up on open paren and comma like vim-lsp
  -- TBD: lsp formatting mappings and/or autocmds (BufWrite*)?

  -- Enable document highlights if supported
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup ZeroKnight_LSP_buffer
        autocmd! * <buffer>
        autocmd CursorHold,CursorHoldI,BufEnter <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved,BufLeave <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  lsp_status.on_attach(client)
end

-- Set diagnostic signs
vim.fn.sign_define('LspDiagnosticsSignError', {text = ''})
vim.fn.sign_define('LspDiagnosticsSignWarning', {text = ''})
vim.fn.sign_define('LspDiagnosticsSignInformation', {text = ''})
vim.fn.sign_define('LspDiagnosticsSignHint', {text = ''})

-- Set up lsp-status
lsp_status.config {
  current_function = true,
  diagnostics = false,  -- Using my own function
  kind_labels = lsp_kinds.symbols
}
lsp_status.register_progress()

-- Configure Language Server settings
local servers = {
  jsonls = {},
  sumneko_lua = require('zeroknight.lsp.sumneko').config,
  pyright = {
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true
        },
        venvPath = {'venv', '.venv'}
      }
    }
  },
  vimls = {}
}
-- Run the setup for each server
for ls, config in pairs(servers) do
  lspconfig[ls].setup(
    vim.tbl_extend('error', {on_attach = lsp_buffer_setup}, config)
  )
end

-- Set up highlighting
require 'zeroknight.lsp.highlight'

vim.cmd [[
  augroup ZeroKnight_LSP
    autocmd!
    autocmd ColorScheme * lua rerequire('zeroknight.lsp.highlight')
  augroup END
]]

vim.cmd [[command! LspDiagnostics lua vim.lsp.diagnostic.set_loclist()]]

