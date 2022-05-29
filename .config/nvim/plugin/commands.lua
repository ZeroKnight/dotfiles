local command = vim.api.nvim_create_user_command

command(
  'Obsess',
  'Obsession $VIMSESSIONS/<args>.vim',
  { desc = 'Wrapper around tpope/vim-obsession that always saves to $VIMSESSIONS', force = true, nargs = 1 }
)
