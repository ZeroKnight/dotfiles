local command = vim.api.nvim_create_user_command

command('Cd', 'cd %:p:h<Bar>pwd', { desc = 'Change working directory to the current file' })
command('Lcd', 'lcd %:p:h<Bar>pwd', { desc = 'Change window working directory to the current file' })
command('Tcd', 'tcd %:p:h<Bar>pwd', { desc = 'Change tab working directory to the current file' })
