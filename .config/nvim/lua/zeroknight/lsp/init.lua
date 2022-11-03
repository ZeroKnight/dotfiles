-- Language Server Configuration

local lsp = vim.lsp
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
if not has_lspconfig then
  return
end
local lsp_status = require 'lsp-status'
local lsp_kinds = require 'zeroknight.lsp.kinds'

local wk = require 'which-key'

local M = {}

local lsp_keymap = {
  ['<LocalLeader>'] = {
    c = {
      name = 'code/calls',
      a = { '<Cmd>CodeActionMenu<CR>', '[LSP] Code Actions' },
      A = {
        function()
          lsp.buf.code_action()
        end,
        '[LSP] Code Actions (Native)',
      },
      i = {
        function()
          lsp.buf.incoming_calls()
        end,
        '[LSP] Incoming Calls',
      },
      o = {
        function()
          lsp.buf.outgoing_calls()
        end,
        '[LSP] Outgoing Calls',
      },
    },
    d = {
      name = 'document',
      s = { '[LSP] Document Symbols' },
    },
    p = {
      name = 'preview/peek',
      d = {
        function()
          M.peek 'definition'
        end,
        '[LSP] Peek Definition',
      },
      D = {
        function()
          M.peek 'declaration'
        end,
        '[LSP] Peek Declaration',
      },
    },
    r = {
      name = 'restart',
      c = {
        function()
          vim.lsp.stop_client(vim.tbl_values(lsp.buf_get_clients(0)))
          vim.cmd 'e'
        end,
        '[LSP] Restart buffer clients',
      },
      C = {
        function()
          vim.lsp.stop_client(lsp.get_active_clients())
          vim.cmd 'e'
        end,
        '[LSP] Restart ALL clients',
      },
    },
    td = {
      function()
        lsp.buf.type_definition()
      end,
      '[LSP] Jump to Type Definition',
    },
    w = {
      name = 'workspace',
      s = { '[LSP] Workspace Symbols' },
    },
  },
  ['<F2>'] = {
    function()
      lsp.buf.rename()
    end,
    '[LSP] Rename Symbol',
  },
  g = {
    name = 'goto',
    d = {
      function()
        lsp.buf.definition()
      end,
      '[LSP] Jump to Definition',
    },
    D = {
      function()
        lsp.buf.declaration()
      end,
      '[LSP] Jump to Declaration',
    },
    I = {
      function()
        lsp.buf.implementation()
      end,
      '[LSP] Jump to Implementation',
    },
    r = { '[LSP] Browse References' },
  },
  K = {
    function()
      lsp.buf.hover()
    end,
    '[LSP] Show Hover',
  },
}

-- Mappings for both NORMAL and INSERT mode
local lsp_keymap_ni = {
  ['<C-s>'] = {
    function()
      lsp.buf.signature_help()
    end,
    '[LSP] Signature Help',
  },
}

local lsp_keymap_x = {
  ['<LocalLeader>'] = {
    c = {
      name = 'code',
      a = { '<Cmd>CodeActionMenu<CR>', '[LSP] Code Actions' },
    },
  },
}

-- Main `on_attach` callback
function M.lsp_buffer_setup(client, bufnr)
  local map_telescope = require('plugin.telescope').map_telescope

  map_telescope('gr', {
    picker = 'lsp_references',
    opts = {
      sorting_strategy = 'ascending',
      ignore_filename = true,
    },
    buffer = true,
  })
  map_telescope('<LocalLeader>ds', { 'lsp_document_symbols', opts = { ignore_filename = true }, buffer = true })
  map_telescope('<LocalLeader>ws', { 'lsp_workspace_symbols', opts = { ignore_filename = true }, buffer = true })

  -- Enable document highlights if supported
  if client.server_capabilities.documentHighlightProvider then
    local lsp_hl_augroup = augroup('ZeroKnight_LSP_Highlighting', { clear = false })
    vim.api.nvim_clear_autocmds { group = lsp_hl_augroup, buffer = bufnr }
    autocmd({ 'CursorHold', 'CursorHoldI', 'BufEnter', 'CursorMoved', 'BufLeave' }, {
      desc = 'LSP Document Highlighting',
      buffer = bufnr,
      group = lsp_hl_augroup,
      callback = function(ctx)
        if vim.tbl_contains({ 'CursorHold', 'CursorHoldI', 'BufEnter' }, ctx.event) then
          vim.lsp.buf.document_highlight()
        elseif vim.tbl_contains({ 'CursorMoved', 'BufLeave' }, ctx.event) then
          vim.lsp.buf.clear_references()
        end
      end,
    })
  end

  -- Automatic signature help
  local trigger_chars = vim.tbl_get(client.server_capabilities, 'signatureHelpProvider', 'triggerCharacters') or {}
  for _, char in ipairs(trigger_chars) do
    vim.keymap.set('i', char, function()
      vim.defer_fn(vim.lsp.buf.signature_help, 0)
      return char
    end, {
      expr = true,
      buffer = bufnr,
    })
  end

  -- Document formatting
  if client.server_capabilities.documentFormattingProvider then
    lsp_keymap['<LocalLeader>'].c.f = {
      function()
        lsp.buf.format { async = true }
      end,
      '[LSP] Format Document',
    }
    local lsp_fmt_augroup = augroup('ZeroKnight_LSP_Formatting', { clear = false })
    autocmd('BufWritePre', {
      desc = 'Format document on write',
      buffer = bufnr,
      group = lsp_fmt_augroup,
      callback = function()
        require('zeroknight.util.formatting').lsp_format_on_write()
      end,
    })
  end
  if client.server_capabilities.documentRangeFormattingProvider then
    lsp_keymap_x['<LocalLeader>'].c.f = {
      function()
        lsp.buf.range_formatting()
      end,
      '[LSP] Format Range',
    }
  end

  lsp_status.on_attach(client)

  wk.register(lsp_keymap, { buffer = bufnr })
  wk.register(lsp_keymap_ni, { buffer = bufnr, mode = 'n' })
  wk.register(lsp_keymap_ni, { buffer = bufnr, mode = 'i' })
  wk.register(lsp_keymap_x, { buffer = bufnr, mode = 'x' })
end

function M.init()
  -- Set up lsp-status
  lsp_status.config {
    current_function = true,
    diagnostics = false, -- Using my own function
    kind_labels = lsp_kinds.symbols,
  }
  lsp_status.register_progress()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- if packer_loaded 'nvim-cmp' and packer_loaded 'cmp-nvim-lsp' then
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  -- end

  -- Run the setup for each server
  for ls, config in pairs(require 'zeroknight.lsp.servers') do
    if not config.disabled then
      if config.on_attach ~= nil then
        -- Server-specific `on_attach` additions
        local override = config.on_attach
        config.on_attach = function(...)
          override(...)
          M.lsp_buffer_setup(...)
        end
      else
        config.on_attach = M.lsp_buffer_setup
      end
      config.capabilities = capabilities
      lspconfig[ls].setup(config)
    end
  end

  -- null-ls
  if not vim.g.null_ls_disable then
    require 'zeroknight.lsp.servers.null-ls'
  end

  -- Set up highlighting
  require 'zeroknight.lsp.highlight'

  local lsp_augroup = augroup('ZeroKnight_LSP', {})
  autocmd('ColorScheme', {
    desc = 'Reload LSP highlighting on colorscheme change',
    group = lsp_augroup,
    callback = function()
      rerequire 'zeroknight.lsp.highlight'
    end,
  })
end

local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    require('vim.lsp.log').info 'No location found for preview'
    return nil
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.preview_location(result[1])
  else
    vim.lsp.util.preview_location(result)
  end
end

function M.peek(what)
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/' .. what, params, preview_location_callback)
end

return M
