-- Linter Configuration

require('lint').linters_by_ft = {
  bash = {'shellcheck', 'bashate'},
  lua = {'selene'},
  python = {'bandit', 'mypy', 'flake8'},
  markdown = {'markdownlint', 'vale'},
  sh = {'shellcheck', 'bashate'},
  vim = {'vint'},
}

vim.cmd [[command! Lint lua require('lint').try_lint()]]
vim.cmd [[
  augroup ZeroKnight_Lint
    autocmd!
    autocmd BufWritePost * silent! lua require('lint').try_lint()
  augroup END
]]
