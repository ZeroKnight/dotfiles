-- Language Server Configuration

local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
if not has_lspconfig then
  return
end
local lsp_status = require('lsp-status')
local lsp_kinds = require('zeroknight.lsp.kinds')



local function lsp_buffer_setup(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local map_telescope = require('plugin.telescope').map_telescope

  -- Language Server method mappings
  local function map_lsp_method(modes, kind, lhs, method)
    for mode in vim.gsplit(modes, '') do
      vim.api.nvim_buf_set_keymap(
        bufnr, mode, lhs,
        string.format('<Cmd>lua vim.lsp.%s.%s()<CR>', kind, method),
        {noremap = true, silent = true}
      )
    end
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  map_lsp_method('n',  'buf',        'gD',              'declaration')
  map_lsp_method('n',  'buf',        'gd',              'definition')
  map_lsp_method('n',  'buf',        'K',               'hover')
  map_lsp_method('n',  'buf',        'gI',              'implementation')
  map_lsp_method('n',  'buf',        ']C',              'incoming_calls')
  map_lsp_method('n',  'buf',        '[C',              'outgoing_calls')
  map_lsp_method('n',  'buf',        '<F2>',            'rename')
  map_lsp_method('ni', 'buf',        '<C-s>',           'signature_help')
  map_lsp_method('n',  'buf',        '<LocalLeader>td', 'type_definition')
  map_lsp_method('ni', 'diagnostic', '<M-d>',           'show_line_diagnostics')
  map_lsp_method('n',  'diagnostic', ']d',              'goto_next')
  map_lsp_method('n',  'diagnostic', '[d',              'goto_prev')

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
  -- TBD lsp formatting mappings and/or autocmds (BufWrite*)?

  -- Reload buffer LSP settings
  vim.api.nvim_buf_set_keymap(
    bufnr, 'n', '<LocalLeader>rr',
    "<Cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients()); vim.cmd('e')<CR>", {}
  )

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

