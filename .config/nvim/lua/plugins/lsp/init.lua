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
        format = {
          format_on_write = true,
        },
      }
    end,
    config = function(_, opts)
      local formatting = require 'plugins.lsp.format'

      formatting.format_on_write = opts.format.format_on_write

      -- Main LSP on_attach
      util.on_attach(function(client, buffer)
        require('plugins.lsp.keymaps').on_attach(client, buffer)
        formatting.on_attach(client, buffer)
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

  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason.nvim' },
    opts = function()
      local builtins = require('null-ls').builtins
      return {
        -- NOTE: Trouble shows the code and source name as well
        diagnostics_format = '#{m}',
        update_in_insert = false,
        border = require('zeroknight.config.ui').borders,
        sources = {
          -- Diagnostics
          builtins.diagnostics.gitlint.with {
            extra_args = { '--contrib', 'contrib-title-conventional-commits' },
          },
          builtins.diagnostics.markdownlint,
          builtins.diagnostics.rstcheck,
          builtins.diagnostics.selene,
          builtins.diagnostics.shellcheck,
          builtins.diagnostics.vale,
          builtins.diagnostics.vint,
          builtins.diagnostics.zsh,

          -- Formatting
          builtins.formatting.black,
          builtins.formatting.isort,
          builtins.formatting.markdownlint,
          builtins.formatting.prettier,
          builtins.formatting.stylua,
          builtins.formatting.trim_newlines.with {
            disabled_filetypes = { 'diff' },
          },
          builtins.formatting.trim_whitespace.with {
            disabled_filetypes = { 'diff' },
          },

          -- Code Actions
          builtins.code_actions.gitsigns.with {
            config = {
              filter_actions = function(title)
                return title:lower():match 'blame' == nil and title:lower():match 'hunk' == nil
              end,
            },
          },

          -- Hover
          builtins.hover.printenv,
        },
      }
    end,
  },

  { 'b0o/SchemaStore.nvim', lazy = true },
}
