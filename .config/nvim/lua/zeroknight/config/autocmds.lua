local augroup = vim.api.nvim_create_augroup
local optl = vim.opt_local
local optg = vim.opt_global

local g = augroup('ZeroKnight', {})
local autocmd = function(events, opts)
  return vim.api.nvim_create_autocmd(events, vim.tbl_extend('force', { group = g }, opts))
end

autocmd({ 'BufWritePre', 'FileWritePre' }, {
  desc = 'Automatically create directories for new files when saving',
  callback = function()
    vim.fn.mkdir(vim.fn.expand '<afile>:p:h', 'p')
  end,
})

autocmd('FileType', {
  desc = 'Many filetype plugins set `formatoptions+=o`. Undo this.',
  callback = function()
    optl.formatoptions:remove 'o'
  end,
})

local relnum_off_events = { 'WinLeave', 'InsertEnter' }
local relnum_on_events = { 'WinEnter', 'BufWinEnter', 'VimEnter', 'InsertLeave' }
autocmd(vim.tbl_flatten { relnum_off_events, relnum_on_events }, {
  desc = 'Toggle relative line-numbering in various cases',
  callback = function(ctx)
    if vim.o.number then
      if vim.tbl_contains(relnum_off_events, ctx.event) then
        optl.relativenumber = false
      elseif vim.tbl_contains(relnum_on_events, ctx.event) then
        optl.relativenumber = true
      end
    end
  end,
})

autocmd({ 'WinEnter', 'WinLeave' }, {
  desc = 'Only show cursor(line|column) in the active window',
  callback = function(ctx)
    if ctx.event == 'WinLeave' then
      optl.cursorline = false
      optl.cursorcolumn = false
    elseif ctx.event == 'WinEnter' then
      optl.cursorline = optg.cursorline:get()
      optl.cursorcolumn = optg.cursorcolumn:get()
    end
  end,
})

autocmd('TermOpen', {
  desc = 'Terminal Settings',
  callback = function()
    for _, o in ipairs { 'number', 'relativenumber', 'cursorline', 'cursorcolumn' } do
      optl[o] = false
    end
  end,
})

autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  callback = function()
    require('vim.highlight').on_yank { timeout = 300, higroup = 'LspReferenceWrite', on_visual = false }
  end,
})

autocmd('QuickFixCmdPost', {
  desc = 'Automatically open quickfix/loclist results when grepping',
  pattern = '{l,}{vim,help,}grep',
  callback = function(ctx)
    if vim.startswith(ctx.match, 'l') then
      vim.cmd 'silent lwindow'
    else
      vim.cmd 'silent cwindow'
    end
  end,
})
