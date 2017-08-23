" Mappings
"==============================

" Simple, quick Esc alternative {{{1
inoremap jk <Esc>
inoremap JK <Esc>
inoremap Jk <Esc>
inoremap jK <Esc>

" Change (l)cwd to that of the current file {{{1
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <Leader>lcd :lcd %:p:h<CR>:pwd<CR>

" Quick :Bdelete (vim-bbye) {{{1
nnoremap <Leader>d :Bdelete<CR>

" Quick-edit .vimrc {{{1
nnoremap <Leader>vr :tabedit $MYVIMRC<CR>

" Quick-edit UltiSnips for current filetype {{{1
nnoremap <Leader>ue :UltiSnipsEdit<CR>

" Clear search highlights {{{1
nnoremap <silent> <Leader>/ :nohls<CR>

" Highlight word under cursor without jumping {{{1
nnoremap <Leader>hw *<C-o>

" GitGutter hunk jumping {{{1
nnoremap ]h :GitGutterNextHunk<CR>
nnoremap [h :GitGutterPrevHunk<CR>

" Move cursor to the middle of a line {{{1
noremap <silent> gm :call cursor(0, virtcol('$')/2)<CR>

" F4 - Toggle Tagbar {{{1
nnoremap <silent> <F4> :TagbarToggle<CR>
inoremap <silent> <F4> <C-o>:TagbarToggle<CR>

" F5 - Toggle UndoTree {{{1
nnoremap <silent> <F5> :UndotreeToggle<CR>
inoremap <silent> <F5> <C-o>:UndotreeToggle<CR>

" F6 - Toggle Signature {{{1
nnoremap <silent> <F6> :SignatureToggleSigns<CR>
inoremap <silent> <F6> <C-o>:SignatureToggleSigns<CR>

" C-F12 - Generate tags file {{{1
"nnoremap <C-F12> :!ctags -R --c++-kinds=+p --fields=+liaS --extra=+q .<CR>

" Yank entire buffer {{{1
nnoremap gy :%y+<CR>

" More logical Y {{{1
noremap Y y$

" Split line (thanks, /u/frumsfrums) {{{1
nnoremap gK f<space>r<CR>

" Yank/Paste Shortcuts {{{1
nnoremap <C-Ins> "+y
vnoremap <C-Ins> "+y
nnoremap <S-Ins> "+p
inoremap <S-Ins> <C-o>"+p
vnoremap <S-Ins> "-d"+P

" Toggle Indent Guides {{{1
nnoremap <silent> <Leader>ig :IndentLinesToggle<CR>

" Window Switching {{{1
nnoremap <C-H> h
nnoremap <C-J> j
nnoremap <C-K> k
nnoremap <C-L> l

" Fugitive {{{1
nnoremap <silent> <Leader>gs :Gstatus<CR>

"}}}

" Abbreviations
"==============================

" vim: fdm=marker