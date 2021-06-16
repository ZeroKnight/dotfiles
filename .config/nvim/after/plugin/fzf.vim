" junegunn/fzf

if !(exists('g:loaded_fzf') && exists('g:loaded_fzf_vim'))
  finish
endif

" fzf Mappings
nnoremap <silent> <C-p> <Cmd>Buffers<CR>
nnoremap <silent> <Leader>f <Cmd>Files<CR>

lua <<EOF
vim.g.fzf_colors = {
  fg      = {'fg', 'Normal'},
  bg      = {'bg', 'Normal'},
  hl      = {'fg', 'Comment'},
  ['fg+'] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'},
  ['bg+'] = {'bg', 'CursorLine', 'CursorColumn'},
  ['hl+'] = {'fg', 'Statement'},
  info    = {'fg', 'PreProc'},
  border  = {'fg', 'Ignore'},
  prompt  = {'fg', 'Conditional'},
  pointer = {'fg', 'Exception'},
  marker  = {'fg', 'Keyword'},
  spinner = {'fg', 'Label'},
  header  = {'fg', 'Comment'}
}
EOF

