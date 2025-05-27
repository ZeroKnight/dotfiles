-- Debugging plugins
--
-- Plugins that aid in and/or add debugging features and tools

---@type LazySpec
return {
  -- Debug Adapter Protocol (DAP)
  -- TODO: Dive into DAP
  {
    'mfussenegger/nvim-dap',
    enabled = false,
  },

  {
    'jbyuki/one-small-step-for-vimkind',
    dependencies = { 'mfussenegger/nvim-dap' },
    enabled = false,
  },
}
