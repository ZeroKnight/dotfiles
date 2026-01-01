-- LSP Plugins
--
-- Tools, UI components, and anything else related to leveraging the Language
-- Server Protocol and its ecosystem.

local util = require 'zeroknight.util'

---@type LazySpec
return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            'lazy.nvim',
            'nvim-lspconfig',
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
          integrations = {
            lspconfig = true,
            cmp = true,
          },
        },
      },
      { 'folke/neoconf.nvim', opts = {} },
      'mason.nvim',
      'mason-lspconfig.nvim',
    },
    -- Since lspconfig has no options of its own, we'll store our own assorted
    -- LSP options here.
    opts = function()
      return {
        capabilities = {},
      }
    end,
    config = function(_, opts)
      util.on_attach(require('plugins.lsp.keymaps').on_attach, 'Set up LSP-related keymaps')

      util.on_attach(function(client, _)
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_foldingRange) then
          local win = vim.api.nvim_get_current_win()
          vim.wo[win][0].foldmethod = 'expr'
          vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end
      end, 'Enable LSP-provided folding when available')

      if not util.has_plugin 'conform.nvim' then
        util.on_attach(function(client, buffer)
          if client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
            vim.bo[buffer].formatexpr = 'v:lua.vim.lsp.formatexpr()'
          end
        end, 'Use LSP-backed foldexpr')
      end

      -- Build our default client capabilities
      vim.lsp.config('*', {
        capabilities = vim.tbl_deep_extend(
          'force',
          vim.lsp.protocol.make_client_capabilities(),
          require('cmp_nvim_lsp').default_capabilities(),
          opts.capabilities
        ),
      })

      for server, config in pairs(require 'plugins.lsp.servers') do
        vim.lsp.config(server, config)
        vim.lsp.enable(server, not config.disabled)
      end

      -- Live reload LS settings when server settings change
      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = '*/nvim/lua/plugins/lsp/servers.lua',
        group = vim.api.nvim_create_augroup('ZeroKnight.lsp.reload', { clear = true }),
        desc = 'Reload language server settings on config change',
        callback = function()
          local servers = rerequire 'plugins.lsp.servers'
          vim.notify(
            'Language Server settings file changed. Updating server configurations.',
            vim.log.levels.WARN,
            { title = 'ZeroKnight LSP' }
          )
          for server, config in pairs(servers) do
            util.update_ls_config(server, config or {})
          end
        end,
      })
    end,
  },

  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = 'Mason',
    opts = function()
      return {
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
        pip = { upgrade_pip = true },
        ui = { border = require('zeroknight.config.ui').borders },
      }
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim' },
    lazy = true,
    opts = {
      automatic_enable = true,
      ensure_installed = { 'lua_ls', 'jsonls', 'taplo' },
    },
  },

  { 'b0o/SchemaStore.nvim', lazy = true },
}
