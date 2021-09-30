-- Linter Configuration

-- TBD: Use luacheck for linting and disable sumneko diagnostics? does that disable *all* of them? maybe use both?

require('lint').linters_by_ft = {
  bash = {'shellcheck'},
  lua = {'luacheck'},
  python = {'bandit', 'mypy', 'flake8'},
  markdown = {'vale'},
  sh = {'shellcheck'},
  vim = {'vint'},
}

vim.cmd [[command! Lint lua require('lint').try_lint()]]
vim.cmd [[
  augroup ZeroKnight_Lint
    autocmd!
    autocmd BufWritePost * silent! lua require('lint').try_lint()
  augroup END
]]
