-- Completion Settings

vim.opt.completeopt = {'menuone', 'noselect'}  -- Required by compe

require('compe').setup {
  enabled = true,
  autocomplete = true,
  documentation = true,
  preselect = 'enable',
  min_length = 1,
  throttle_time = 200,
  source_timeout = 250,
  incomplete_delay = 400,
  max_kind_width = 50,

  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    ultisnips = true,
    nvim_treesitter = false  -- TODO: test
  }
}

local opts = {noremap = true, silent = true, expr = true}
local function compe_keymap(lhs, compe_func)
  vim.api.nvim_set_keymap('i', lhs, 'compe#' .. compe_func, opts)
end

compe_keymap('<C-p>', [[complete()]])
compe_keymap('<CR>',  [[confirm('<CR>')]])
compe_keymap('<Esc>', [[close('<Esc>')]])
compe_keymap('<C-f>', [[scroll({'delta': +4})]])  -- Documentation window scrolling
compe_keymap('<C-b>', [[scroll({'delta': -4})]])

