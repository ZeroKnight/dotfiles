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

  -- Vim
  {
    'tpope/vim-scriptease',
    ft = 'vim',
    keys = {
      { 'zS', desc = 'Show syntax highlighting groups under cursor' },
      { 'g=', desc = 'eval() text and replace it with the result', mode = { 'n', 'x' } },
      { 'g==', desc = 'eval() line and replace it with the result' },
    },
      -- stylua: ignore
      cmd = {
        'Breakadd', 'Breakdel', 'Disarm', 'Messages', 'Runtime', 'Scriptnames', 'Time', 'Verbose',
        'Vedit', 'Vopen', 'Vread', 'Vsplit', 'Vvsplit', 'Vtabedit', 'Vpedit',
      },
  },
}
