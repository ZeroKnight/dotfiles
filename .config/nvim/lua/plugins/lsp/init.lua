-- LSP Plugins
--
-- Tools, UI components, and anything else related to leveraging the Language
-- Server Protocol and its ecosystem.

local util = require 'zeroknight.util'

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'folke/neodev.nvim', opts = {} },
      { 'folke/neoconf.nvim', opts = {} },
      'mason.nvim',
      'mason-lspconfig.nvim',
    },
    -- Since lspconfig has no options of its own, we'll store our own assorted
    -- LSP options here.
    opts = function()
      return {
        capabilities = {
          textDocument = { completion = { completionItem = { snippetSupport = true } } },
        },
      }
    end,
    config = function(_, opts)
      -- Main LSP on_attach
      util.on_attach(function(client, buffer)
        require('plugins.lsp.keymaps').on_attach(client, buffer)
      end, 'Initialize core LSP functionality')

      -- Build our client capabilities
      local capabilities = vim.tbl_deep_extend(
        'force',
        vim.lsp.protocol.make_client_capabilities(),
        require('cmp_nvim_lsp').default_capabilities(),
        opts.capabilities
      )

      -- Proxy server setup through mason-lspconfig so that it can dynamically
      -- configure newly-installed servers.
      require('mason-lspconfig').setup_handlers {
        function(server)
          local config = vim.deepcopy(require('plugins.lsp.servers')[server]) or {}
          if not config.disabled then
            config.capabilities = vim.tbl_deep_extend('force', capabilities, config.capabilities or {})
            require('lspconfig')[server].setup(config)
          end
        end,
      }

      -- Live reload LS settings when server settings change
      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = '*/nvim/lua/plugins/lsp/servers.lua',
        group = vim.api.nvim_create_augroup('ZeroKnight.lsp.reload', { clear = true }),
        desc = 'Reload language server settings on config change',
        callback = function()
          local servers = rerequire 'plugins.lsp.servers'
          vim.notify(
            'Language Server settings file changed. Updating servers...',
            vim.log.levels.WARN,
            { title = 'ZeroKnight LSP' }
          )
          for server, config in pairs(servers) do
            util.update_ls_settings(server, config.settings or {})
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
      automatic_installation = true,
      ensure_installed = { 'lua_ls', 'jsonls', 'taplo' },
    },
  },

  { 'b0o/SchemaStore.nvim', lazy = true },
}
