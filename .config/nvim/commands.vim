" Commands
" ------------------------------------------------------------------------------

" Common typos {{{1
command! W w
command! Q q

" Open :help in a new tab {{{1
cnoreabbrev <expr> ht getcmdtype() == ':' && getcmdline() == 'ht' ? 'tab help' : 'ht'

" Open :help in a vertical split {{{1
cnoreabbrev <expr> hv getcmdtype() == ':' && getcmdline() == 'hv' ? 'vert help' : 'hv'

" Todo: Load Comment Tags into the Location List {{{1
command! -nargs=0 Todo execute 'LAg -A ' . string(g:zeroknight.comment_tags)

" Obsess: Wrapper around tpope/vim-obsession that always saves to $VIMSESSIONS {{{1
command! -nargs=1 Obsess Obsession $VIMSESSIONS/<args>.vim

" Rg: ripgrep current directory via FZF {{{1
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always '
  \   . shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" }}}

" Function Commands
" ------------------------------------------------------------------------------

" TrimTrailingSpace() {{{1
command! -nargs=0 TrimTrailingSpace silent call zerofunc#TrimTrailingSpace()

" Redir() {{{1
command! -nargs=+ Redir silent call zerofunc#Redir('horizontal', <f-args>)
command! -nargs=+ VRedir silent call zerofunc#Redir('vertical', <f-args>)
command! -nargs=+ TRedir silent call zerofunc#Redir('tab', <f-args>)

" vim: fdm=marker
