local command = vim.api.nvim_create_user_command

command('Cd', 'cd %:p:h<Bar>pwd', { desc = 'Change working directory to the current file' })
command('Lcd', 'lcd %:p:h<Bar>pwd', { desc = 'Change window working directory to the current file' })
command('Tcd', 'tcd %:p:h<Bar>pwd', { desc = 'Change tab working directory to the current file' })

command('HelpSide', function(ctx)
  local side = ctx.bang and 'topleft' or 'botright'
  -- WTF: vim.cmd.vertical('...') doesn't work for some reason
  vim.cmd(string.format('vertical %s help %s', side, ctx.args))
  vim.cmd 'vertical resize 80'
end, {
  desc = 'Open a sidebar-like help window',
  nargs = 1,
  complete = 'help',
})
