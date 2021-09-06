" ZeroKnight's Mappings

" These are my general, non-plugin-specific mappings. Plugin-related mappings
" are defined alongside the rest of a particular plugin's configuration,
" located in `after/plugin/<name>.vim`.

" Standard Behavior Overwrites {{{1
" -----------------------------------------------------------------------------

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

" Workaround for C-Space detection
imap <C-@> <C-Space>

" Stay in Visual mode after indenting
vnoremap < <gv
vnoremap > >gv

" Simple Remappings and Shortcuts {{{1
" -----------------------------------------------------------------------------

" Change (l)cwd to that of the current file
nnoremap <Leader>cd <Cmd>cd %:p:h<Bar>pwd<CR>
nnoremap <Leader>lcd <Cmd>lcd %:p:h<Bar>pwd<CR>
nnoremap <Leader>tcd <Cmd>tcd %:p:h<Bar>pwd<CR>

" Toggle Spellcheck
nnoremap <silent> <LocalLeader>s <Cmd>setlocal spell!<CR>

" Switch to Visual-Block mode from Visual mode a bit quicker
xnoremap v <C-v>

" Editing {{{1
" -----------------------------------------------------------------------------

" Save and execute file
nnoremap <silent> <Leader>wx <Cmd>call zeroknight#util#save_and_exec()<CR>

" Yank entire buffer to clipboard
nnoremap gy <Cmd>%y+<CR>

" Split line (thanks, /u/frumsfrums)
nnoremap gK f<Space>r<CR>

" Rename word/WORD under cursor
nnoremap <Leader>rw :%s/\<<C-r><C-w>\>/
nnoremap <Leader>rW :%s/\<<C-r><C-a>\>/

" TrimTrailingSpace()
nnoremap <silent> <Leader>ts <Cmd>call zeroknight#util#TrimTrailingSpace()<CR>

" Enable . in visual mode
vnoremap . <Cmd>normal .<CR>

" Precise paragraph movement (thanks, /u/kshenoy42)
nnoremap <expr> g{ len(getline(line('.')-1)) > 0 ? '{+' : '{-'
nnoremap <expr> g} len(getline(line('.')+1)) > 0 ? '}-' : '}+'

" UI Related {{{1
" -----------------------------------------------------------------------------

" Clear search highlights
nnoremap <silent> <Leader>/ <Cmd>nohls<CR>

" Window Switching
nnoremap <C-H> <C-w>h
nnoremap <C-J> <C-w>j
nnoremap <C-K> <C-w>k
nnoremap <C-L> <C-w>l

" Window Resizing
nnoremap <M-Left> <C-w>5<
nnoremap <M-Right> <C-w>5>
nnoremap <M-Up> <C-w>5+
nnoremap <M-Down> <C-w>5-

" Allow <Tab> and <S-Tab> to cycle the popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" }}}

" Abbreviations (See also: after/plugin/abolish.vim)
" ------------------------------------------------------------------------------

" Lazy abbreviations {{{1

inoreabbrev afaik as far as I know
inoreabbrev afaict as far as I can tell
inoreabbrev idk I don't know
inoreabbrev tbh to be honest
inoreabbrev tbf to be fair

" Command Typos {{{1

cabbrev W w
cabbrev Q q
cabbrev E e

" Command Shortcuts {{{1

cnoreabbrev hv vert help
cnoreabbrev ht tab help

" }}}

" vim: fdm=marker
