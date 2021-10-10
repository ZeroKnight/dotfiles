-- Linter Configuration

-- NOTE: Vale is highly extensible, so it can "include" other prose linters

local sh_common = {'shellcheck', 'bashate'}

require('lint').linters_by_ft = {
  bash = sh_common,
  lua = {'selene'},
  markdown = {'markdownlint', 'vale'},
  python = {'bandit', 'mypy', 'flake8'},
  sh = sh_common,
  rst = {'rstcheck', 'vale'},
  text = {'vale'},
  vim = {'vint'},
}

vim.cmd [[command! Lint lua require('lint').try_lint()]]
vim.cmd [[
  augroup ZeroKnight_Lint
    autocmd!
    autocmd BufWritePost * silent! lua require('lint').try_lint()
  augroup END
]]
