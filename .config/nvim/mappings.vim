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

" Precise paragraph movement (thanks, /u/kshenoy42)
nnoremap <expr> g{ len(getline(line('.')-1)) > 0 ? '{+' : '{-'
nnoremap <expr> g} len(getline(line('.')+1)) > 0 ? '}-' : '}+'

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

" Highlight word or WORD under cursor without side-effects
nnoremap <silent> <Leader>hw :let @/= '\<' . expand('<cword>') . '\>' <Bar>
  \ set hls<CR>
nnoremap <silent> <Leader>hW :let @/=expand('<cword>') <Bar> set hls<CR>

" Toggle Spellcheck
nnoremap <silent> <Leader>s :setlocal spell!<CR>

" Yank/Paste Shortcuts
nnoremap <C-Ins> "+y
vnoremap <C-Ins> "+y
nnoremap <S-Ins> "+p
inoremap <S-Ins> <C-o>"+p
vnoremap <S-Ins> "-d"+P

" Rename word under cursor
nnoremap <Leader>rw :%s/\<<C-r><C-w>\>/

" Remappings {{{1
" ------------------------------------------------------------------------------

" More logical Y
noremap Y y$

" More sensible mark jumping. ` is at the beginning of the keyboard, so have its
" behavior match its position. It also "points" toward the start of the line.
" Also, ' is easier to reach and what I want more often anyway.
noremap ` '
noremap ' `

" Always move by visual line
nnoremap k gk
nnoremap j gj
nnoremap <Up> gk
nnoremap <Down> gj

" Workaround for C-Space detection
imap <C-@> <C-Space>

" Movement {{{1
" ------------------------------------------------------------------------------

" Move cursor to the middle of a line
noremap <silent> gm :call cursor(0, virtcol('$')/2)<CR>

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

" fzf Mappings
nnoremap <C-p> :Buffers<CR>
nnoremap <Leader>f :Files<CR>

"}}}

" Function Mappings
" ------------------------------------------------------------------------------

" RecompileYCM() {{{1
nnoremap <Leader>ycm :<C-U>call zerofunc#RecompileYCM(v:count)<CR>

" TrimTrailingSpace() {{{1
nnoremap <silent> <Leader>ts :call zerofunc#TrimTrailingSpace()<CR>

" }}}

" Abbreviations (See also: after/plugin/abolish.vim)
" ------------------------------------------------------------------------------

inoreabbrev afaik as far as I know
inoreabbrev afaict as far as I can tell
inoreabbrev idk I don't know
inoreabbrev tbh to be honest
inoreabbrev tbf to be fair

" vim: fdm=marker
