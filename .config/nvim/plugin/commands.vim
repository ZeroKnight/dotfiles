" Commands
" ------------------------------------------------------------------------------

" Obsess: Wrapper around tpope/vim-obsession that always saves to $VIMSESSIONS {{{1
command! -nargs=1 Obsess Obsession $VIMSESSIONS/<args>.vim

" Rg: ripgrep current directory via FZF {{{1
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '
  \   . shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', 'ctrl-/'),
  \   <bang>0)

" }}}

" Function Commands
" ------------------------------------------------------------------------------

" TrimTrailingSpace() {{{1
command! -nargs=0 TrimTrailingSpace silent call zeroknight#util#TrimTrailingSpace()

" Redir() {{{1
command! -nargs=+ Redir silent call zeroknight#util#Redir('horizontal', <f-args>)
command! -nargs=+ VRedir silent call zeroknight#util#Redir('vertical', <f-args>)
command! -nargs=+ TRedir silent call zeroknight#util#Redir('tab', <f-args>)

" vim: fdm=marker
