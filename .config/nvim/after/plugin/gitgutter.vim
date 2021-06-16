" airblade/vim-gitgutter

if !exists('g:loaded_fugitive')
  finish
endif

let g:gitgutter_grep = executable('rg') ? 'rg' : 'grep'

