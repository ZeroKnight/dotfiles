let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Documents/Coding/Projects/IRCBots/faqbot
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +120 ~/Documents/Coding/Projects/IRCBots/ZeroBot/src/config.cpp
badd +176 src/faqbot.cpp
badd +62 src/faqbot.hpp
badd +27 config.xml
badd +183 src/faqbot-irc.cpp
badd +35 Makefile
badd +44 Makefile.
badd +0 TODO
silent! argdel *
winpos 1 40
edit src/faqbot.hpp
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 1 + 25) / 50)
exe '2resize ' . ((&lines * 46 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 32 + 84) / 168)
exe '3resize ' . ((&lines * 19 + 25) / 50)
exe 'vert 3resize ' . ((&columns * 94 + 84) / 168)
exe '4resize ' . ((&lines * 19 + 25) / 50)
exe 'vert 4resize ' . ((&columns * 94 + 84) / 168)
exe '5resize ' . ((&lines * 6 + 25) / 50)
exe 'vert 5resize ' . ((&columns * 94 + 84) / 168)
exe '6resize ' . ((&lines * 14 + 25) / 50)
exe 'vert 6resize ' . ((&columns * 40 + 84) / 168)
exe '7resize ' . ((&lines * 31 + 25) / 50)
exe 'vert 7resize ' . ((&columns * 40 + 84) / 168)
argglobal
enew
file -MiniBufExplorer-
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
wincmd w
argglobal
enew
file NERD_tree_2
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
wincmd w
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 44 - ((3 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
44
normal! 042l
wincmd w
argglobal
edit src/faqbot-irc.cpp
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
67,86fold
56,89fold
207,243fold
56
normal! zo
67
normal! zo
56
normal! zc
let s:l = 186 - ((8 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
186
normal! 043l
wincmd w
argglobal
edit Makefile
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 48 - ((3 * winheight(0) + 3) / 6)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
48
normal! 0
wincmd w
argglobal
edit TODO
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 6 - ((5 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
6
normal! 0
wincmd w
argglobal
edit config.xml
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 14 - ((13 * winheight(0) + 15) / 31)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
14
let s:c = 9 - ((7 * winwidth(0) + 20) / 40)
if s:c > 0
  exe 'normal! 0' . s:c . 'lzs' . (9 - s:c) . 'l'
else
  normal! 09l
endif
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 1 + 25) / 50)
exe '2resize ' . ((&lines * 46 + 25) / 50)
exe 'vert 2resize ' . ((&columns * 32 + 84) / 168)
exe '3resize ' . ((&lines * 19 + 25) / 50)
exe 'vert 3resize ' . ((&columns * 94 + 84) / 168)
exe '4resize ' . ((&lines * 19 + 25) / 50)
exe 'vert 4resize ' . ((&columns * 94 + 84) / 168)
exe '5resize ' . ((&lines * 6 + 25) / 50)
exe 'vert 5resize ' . ((&columns * 94 + 84) / 168)
exe '6resize ' . ((&lines * 14 + 25) / 50)
exe 'vert 6resize ' . ((&columns * 40 + 84) / 168)
exe '7resize ' . ((&lines * 31 + 25) / 50)
exe 'vert 7resize ' . ((&columns * 40 + 84) / 168)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
