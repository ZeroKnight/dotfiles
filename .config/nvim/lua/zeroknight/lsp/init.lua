-- Language Server Configuration

local lsp = vim.lsp
local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
if not has_lspconfig then
  return
end
local lsp_status = require('lsp-status')
local lsp_kinds = require('zeroknight.lsp.kinds')

local wk = require('which-key')
local key = require('zeroknight.util.key')

local function lsp_method(kind, method)
  return string.format('<Cmd>lua vim.lsp.%s.%s()<CR>', kind, method)
end

local lsp_keymap = {
  ['<LocalLeader>'] = {
    c = {
      name = 'code/calls',
      a = {'<Cmd>CodeActionMenu<CR>', '[LSP] Code Actions'},
      A = {'[LSP] Code Actions (Telescope)'},
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
}

local lsp_keymap_x = {
  ['<LocalLeader>'] = {
    c = {
      name = 'code',
      a = {'<Cmd>CodeActionMenu<CR>', '[LSP] Code Actions'},
      A = {'[LSP] Code Actions (Telescope)'},
    }
  }
}

local function lsp_buffer_setup(client, bufnr)
  local map_telescope = require('plugin.telescope').map_telescope

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  map_telescope('gr', {
    picker = 'lsp_references',
    opts = {
      sorting_strategy = 'ascending',
      ignore_filename = true
    },
    buffer = true
  })
  map_telescope('<LocalLeader>cA', {
    'lsp_code_actions', opts = {sorting_strategy = 'ascending'}, buffer = true
  })
  map_telescope('<LocalLeader>cA', {
    'lsp_range_code_actions', opts = {sorting_strategy = 'ascending'}, buffer = true, mode = 'x'
  })
  map_telescope('<LocalLeader>ds', {'lsp_document_symbols', opts = {ignore_filename = true}, buffer = true})
  map_telescope('<LocalLeader>ws', {'lsp_workspace_symbols', opts = {ignore_filename = true}, buffer = true})
  map_telescope('<LocalLeader>dd', {'lsp_document_diagnostics', buffer = true})
  map_telescope('<LocalLeader>wd', {'lsp_workspace_diagnostics', buffer = true})


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

  -- Automatic signature help
  for _, char in ipairs(client.resolved_capabilities.signature_help_trigger_characters) do
    key.inoremap(char, function()
      vim.defer_fn(vim.lsp.buf.signature_help, 0)
      return char
    end, {expr = true, buffer = bufnr})
  end

  -- Document formatting
  if client.resolved_capabilities.document_formatting then
    lsp_keymap['<LocalLeader>'].c.f = {lsp_method('buf', 'formatting'), '[LSP] Format Document'}
    lsp_keymap_x['<LocalLeader>'].c.f = {lsp_method('buf', 'range_formatting'), '[LSP] Format Range'}
    vim.cmd [[
      augroup ZeroKnight_LSP_buffer
        autocmd BufWritePre <buffer> lua require('plugin.formatting').lsp_format_on_write()
      augroup END
    ]]
  end

  lsp_status.on_attach(client)

  wk.register(lsp_keymap,    {buffer = bufnr})
  wk.register(lsp_keymap_ni, {buffer = bufnr, mode = 'n'})
  wk.register(lsp_keymap_ni, {buffer = bufnr, mode = 'i'})
  wk.register(lsp_keymap_x,  {buffer = bufnr, mode = 'x'})
end

-- Set up lsp-status
lsp_status.config {
  current_function = true,
  diagnostics = false,  -- Using my own function
  kind_labels = lsp_kinds.symbols
}
lsp_status.register_progress()

-- Configure Language Server settings
local disabled = {'pyright'}
local servers = {
  jsonls = {},
  sumneko_lua = require('zeroknight.lsp.sumneko').config,
  pylsp = {
    configurationSources = {'flake8'},
    plugins = {
      flake8 = {
        config = vim.env.HOME .. '/.config/flake8',
      },
      pydocstyle = {enabled = true},
    },
  },
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
  if disabled[ls] == nil then
    lspconfig[ls].setup(
      vim.tbl_extend('error', {on_attach = lsp_buffer_setup}, config)
    )
  end
end

-- Set up highlighting
require 'zeroknight.lsp.highlight'

vim.cmd [[
  augroup ZeroKnight_LSP
    autocmd!
    autocmd ColorScheme * lua rerequire('zeroknight.lsp.highlight')
  augroup END
]]
