" ZeroKnight's Mappings

" New Functionality {{{1
" ------------------------------------------------------------------------------

" Yank entire buffer
nnoremap gy :%y+<CR>

" Split line (thanks, /u/frumsfrums)
nnoremap gK f<space>r<CR>

" Comment a copy of the current line (tpope/vim-commentary)
nmap gcy yyPgccj

" Switch to Visual-Block mode from Visual mode a bit quicker
xnoremap v <C-v>

" Enable . in visual mode
vnoremap . :normal .<CR>

" Shortcuts {{{1
" ------------------------------------------------------------------------------

" Change (l)cwd to that of the current file
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <Leader>lcd :lcd %:p:h<CR>:pwd<CR>

" Quick :Bdelete (vim-bbye)
nnoremap <Leader>d :Bdelete<CR>

" Quick-edit .vimrc
nnoremap <Leader>vr :tabedit $MYVIMRC<CR>

" Quick-edit UltiSnips for current filetype
nnoremap <Leader>ue :UltiSnipsEdit<CR>

" Clear search highlights
nnoremap <silent> <Leader>/ :nohls<CR>

" Highlight word under cursor without jumping
nnoremap <Leader>hw *<C-o>

" Yank/Paste Shortcuts
nnoremap <C-Ins> "+y
vnoremap <C-Ins> "+y
nnoremap <S-Ins> "+p
inoremap <S-Ins> <C-o>"+p
vnoremap <S-Ins> "-d"+P

" Remappings {{{1
" ------------------------------------------------------------------------------

" More logical Y
noremap Y y$

" Nicer paragraph movement (thanks, /u/kshenoy42)
nnoremap <expr> { len(getline(line('.')-1)) > 0 ? '{+' : '{-'
nnoremap <expr> } len(getline(line('.')+1)) > 0 ? '}-' : '}+'

" Movement {{{1
" ------------------------------------------------------------------------------

" Move cursor to the middle of a line
noremap <silent> gm :call cursor(0, virtcol('$')/2)<CR>

" GitGutter hunk jumping
nnoremap ]h :GitGutterNextHunk<CR>
nnoremap [h :GitGutterPrevHunk<CR>

" UI Related {{{1
" ------------------------------------------------------------------------------

" F4 - Toggle Tagbar
nnoremap <silent> <F4> :TagbarToggle<CR>
inoremap <silent> <F4> <C-o>:TagbarToggle<CR>

" F5 - Toggle UndoTree
nnoremap <silent> <F5> :UndotreeToggle<CR>
inoremap <silent> <F5> <C-o>:UndotreeToggle<CR>

" F6 - Toggle Signature
nnoremap <silent> <F6> :SignatureToggleSigns<CR>
inoremap <silent> <F6> <C-o>:SignatureToggleSigns<CR>

" Toggle Indent Guides
nnoremap <silent> <Leader>ig :IndentLinesToggle<CR>

" Window Switching
nnoremap <C-H> <C-w>h
nnoremap <C-J> <C-w>j
nnoremap <C-K> <C-w>k
nnoremap <C-L> <C-w>l

" Fugitive
nnoremap <silent> <Leader>gs :Gstatus<CR>

" Insert a newline when closing the popup menu with <Enter>
inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"

" Allow <Tab> and <S-Tab> to cycle the popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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
