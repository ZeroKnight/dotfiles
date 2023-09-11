local augroup = vim.api.nvim_create_augroup
local optl = vim.opt_local
local optg = vim.opt_global

local g = augroup('ZeroKnight', {})
local autocmd = function(events, opts)
  return vim.api.nvim_create_autocmd(events, vim.tbl_extend('force', { group = g }, opts))
end

autocmd({ 'BufWritePre', 'FileWritePre' }, {
  desc = 'Automatically create directories for new files when saving',
  callback = function(event)
    if event.match:match '^%w%w+://' then
      return
    end
    vim.fn.mkdir(vim.fs.dirname(event.match), 'p')
  end,
})

autocmd('FileType', {
  desc = 'Many filetype plugins set `formatoptions+=o`. Undo this.',
  callback = function()
    optl.formatoptions:remove 'o'
  end,
})

autocmd('FileType', {
  desc = 'Close various filetypes/plugin windows with <q>',
  pattern = { 'help', 'man', 'qf', 'fugitive', 'startuptime', 'tsplayground', 'checkhealth' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<Cmd>quit<CR>', { buffer = event.buf, silent = true })
  end,
})

autocmd('FileType', {
  desc = 'Automatically enable spellchecking and word wrap for prose filetypes',
  pattern = { 'text', 'gitcommit', 'markdown', 'rst' },
  callback = function()
    optl.wrap = true
    optl.spell = true
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

-- NOTE: vim.opt_global is bugged; using setlocal instead
autocmd({ 'WinEnter', 'WinLeave' }, {
  desc = 'Only show cursor(line|column) in the active window',
  callback = function(ctx)
    if ctx.event == 'WinLeave' then
      vim.cmd 'setlocal nocursorline nocursorcolumn'
    elseif ctx.event == 'WinEnter' then
      vim.cmd 'setlocal cursorline< cursorcolumn<'
    end
  end,
})

autocmd('TermOpen', {
  desc = 'Terminal Settings',
  callback = function()
    vim.iter({ 'number', 'relativenumber', 'cursorline', 'cursorcolumn' }):each(function(x)
      optl[x] = false
    end)
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
