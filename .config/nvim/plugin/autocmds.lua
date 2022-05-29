local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local opt = vim.opt
local optl = vim.opt_local
local optg = vim.opt_global

local g = augroup('ZeroKnight', {})

autocmd({ 'BufWritePre', 'FileWritePre' }, {
  desc = 'Automatically create directories for new files when saving',
  group = g,
  callback = function()
    vim.fn.mkdir(vim.fn.expand '<afile>:p:h', 'p')
  end,
})

autocmd('BufWritePost', {
  desc = 'Automatically recompile packer schema on write',
  group = g,
  pattern = 'lua/zeroknight/plugins.lua',
  command = 'source <afile> | PackerCompile',
})

autocmd('FileType', {
  desc = 'Many filetype plugins set `formatoptions+=o`. Undo this.',
  group = g,
  callback = function()
    optl.formatoptions:remove 'o'
  end,
})

local relnum_off_events = { 'WinLeave', 'InsertEnter' }
local relnum_on_events = { 'WinEnter', 'BufWinEnter', 'VimEnter', 'InsertLeave' }
autocmd(vim.tbl_flatten { relnum_off_events, relnum_on_events }, {
  desc = 'Toggle relative line-numbering in various cases',
  group = g,
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
  group = g,
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
  group = g,
  callback = function()
    for _, o in ipairs { 'number', 'relativenumber', 'cursorline', 'cursorcolumn' } do
      optl[o] = false
    end
  end,
})

autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = g,
  callback = function()
    require('vim.highlight').on_yank { timeout = 300, higroup = 'LspReferenceWrite', on_visual = false }
  end,
})

autocmd('ColorScheme', {
  desc = 'Redefine highlights on colorscheme change',
  group = g,
  command = 'silent runtime lua/zeroknight/config/highlight.lua',
})
