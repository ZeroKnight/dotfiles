" dense-analysis/ale

if !exists('g:loaded_ale')
  finish
endif

" We have separate plugins for this; just lint, please.
let g:ale_completion_enabled = 0
let g:ale_disable_lsp = 1

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '‼'

let g:ale_fix_on_save = 1

lua <<EOF
vim.g.ale_fixers = {
  python = {'autopep8', 'isort'}
}
EOF

