-- Mason configuration

require('mason').setup {
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,

  pip = { upgrade_pip = true },

  ui = { border = 'single' },
}

require('mason-lspconfig').setup {
  automatic_installation = true,
  ensure_installed = { 'lua_ls', 'jsonls', 'taplo' },
}
