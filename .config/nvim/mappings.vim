" Mappings
" ------------------------------------------------------------------------------

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
nnoremap <C-H> <C-w>h
nnoremap <C-J> <C-w>j
nnoremap <C-K> <C-w>k
nnoremap <C-L> <C-w>l

" Fugitive {{{1
nnoremap <silent> <Leader>gs :Gstatus<CR>

" Enable . in visual mode {{{1
vnoremap . :normal .<CR>

" Insert a newline when closing the popup menu with <Enter> {{{1
inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"

" Allow <Tab> and <S-Tab> to cycle the popup menu {{{1
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" tpope/vim-commentary - Comment a copy of the current line {{{1
nmap gcy yyPgccj

" Switch to Visual-Block mode from Visual mode a bit quicker
xnoremap v <C-v>

"}}}

" Function Mappings
" ------------------------------------------------------------------------------

" RecompileYCM() {{{1
nnoremap <Leader>ycm :<C-U>call zerofunc#RecompileYCM(v:count)<CR>

" TrimTrailingWhiteSpace() {{{1
nnoremap <silent> <Leader>ts :call zerofunc#TrimTrailingWhiteSpace()<CR>
vnoremap <silent> <Leader>ts :call zerofunc#TrimTrailingWhiteSpace()<CR>

" }}}

" Abbreviations (See also: after/plugin/abolish.vim)
" ------------------------------------------------------------------------------

" Misspellings {{{1
abbrev teh the
abbrev cosnt const

" vim: fdm=marker
