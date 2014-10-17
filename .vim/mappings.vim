" Mappings
"==============================

" Sudo Write {{{1
cnoremap w!! w !sudo tee >/dev/null %

" Change cwd to that of the current file {{{1
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Quick-edit .vimrc {{{1
nnoremap <Leader>vr :tabedit $MYVIMRC<CR>

" Quick-edit UltiSnips for current filetype {{{1
nnoremap <Leader>ue :UltiSnipsEdit<CR>

" Clear search highlights {{{1
nnoremap <Leader>/ :nohls<CR>

" Highlight word under cursor without jumping
nnoremap <Leader>hw *<C-o>

" Quick-switch to last buffer
nnoremap <Leader>, :b#<CR>

" GitGutter hunk jumping {{{1
nnoremap ]h :GitGutterNextHunk<CR>
nnoremap [h :GitGutterPrevHunk<CR>

" Move cursor to the middle of a line {{{1
noremap <silent> gm :call cursor(0, virtcol('$')/2)<CR>

" Experimental Esc alternative {{{1
inoremap jk <Esc>
inoremap JK <Esc>
inoremap Jk <Esc>
inoremap jK <Esc>

" F2 - quick save + remove trailing whitespace {{{1
nnoremap <F2> :%s/\s\+$//g<CR>:w<CR>

" F3 - Toggle NERDtree {{{1
nnoremap <F3> :NERDTreeTabsToggle<CR>
vnoremap <F3> :NERDTreeTabsToggle<CR>
inoremap <F3> :NERDTreeTabsToggle<CR>

" F4 - Toggle Tagbar {{{1
nnoremap <F4> :TagbarToggle<CR>
vnoremap <F4> :TagbarToggle<CR>
inoremap <F4> :TagbarToggle<CR>

" F5 - Toggle Gundo {{{1
nnoremap <F5> :GundoToggle<CR>
vnoremap <F5> :GundoToggle<CR>
inoremap <F5> :GundoToggle<CR>

" F6 - Toggle ShowMarks {{{1
nnoremap <F6> :ShowMarksToggle<CR>
vnoremap <F6> :ShowMarksToggle<CR>
inoremap <F6> :ShowMarksToggle<CR>

" C-F12 - Generate tags file for OmniCppComplete {{{1
noremap <C-F12> :!ctags -R --c++-kinds=+p --fields=+liaS --extra=+q .<CR>

" Yank entire buffer {{{1
nnoremap gy :%y+<cr>

" More logical Y {{{1
noremap Y y$

" Yank/Paste Shortcuts {{{1
nnoremap <C-Ins> "*y
vnoremap <C-Ins> "*y
nnoremap <S-Ins> "*p
inoremap <S-Ins> <C-o>"*p
vnoremap <S-Ins> "-d"*P

" Window Switching {{{1
nnoremap <C-H> h
nnoremap <C-J> j
nnoremap <C-K> k
nnoremap <C-L> l

" Tab Cycling {{{1
"nnoremap <C-Tab> :tabnext<CR>
"inoremap <C-Tab> :tabnext<CR>
"vnoremap <C-Tab> :tabnext<CR>
"nnoremap <C-S-Tab> :tabprev<CR>
"inoremap <C-S-Tab> :tabprev<CR>
"vnoremap <C-S-Tab> :tabprev<CR>

" vim: fdm=marker
