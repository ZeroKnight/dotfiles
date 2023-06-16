local command = vim.api.nvim_create_user_command

local function make_cd_cmd(cmd, desc)
  command(cmd, function(ctx)
    local buf_parent = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    vim.cmd[string.lower(cmd)](vim.fs.joinpath(buf_parent, ctx.args))
    vim.cmd.pwd()
  end, { desc = desc, nargs = '?', complete = 'dir' })
end

make_cd_cmd('Cd', 'Change global working directory relative to the current file')
make_cd_cmd('Lcd', 'Change window working directory relative to the current file')
make_cd_cmd('Tcd', 'Change tab working directory relative to the current file')

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
