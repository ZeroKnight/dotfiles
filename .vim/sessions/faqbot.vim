let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Documents/Development/Projects/IRCBots/faqbot
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +98 src/faqbot.cpp
badd +56 src/faqbot.hpp
badd +25 faq.xml
badd +1 src/util.cpp
badd +5 data/help/faq
badd +22 src/Makefile
badd +0 TODO
badd +1 config.xml
silent! argdel *
winpos 0 40
edit src/faqbot.hpp
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
3wincmd h
wincmd w
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
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 31 + 136) / 273)
exe 'vert 2resize ' . ((&columns * 29 + 136) / 273)
exe '3resize ' . ((&lines * 1 + 33) / 66)
exe 'vert 3resize ' . ((&columns * 147 + 136) / 273)
exe '4resize ' . ((&lines * 31 + 33) / 66)
exe 'vert 4resize ' . ((&columns * 147 + 136) / 273)
exe '5resize ' . ((&lines * 30 + 33) / 66)
exe 'vert 5resize ' . ((&columns * 147 + 136) / 273)
exe '6resize ' . ((&lines * 16 + 33) / 66)
exe 'vert 6resize ' . ((&columns * 63 + 136) / 273)
exe '7resize ' . ((&lines * 32 + 33) / 66)
exe 'vert 7resize ' . ((&columns * 63 + 136) / 273)
exe '8resize ' . ((&lines * 14 + 33) / 66)
exe 'vert 8resize ' . ((&columns * 63 + 136) / 273)
argglobal
enew
file NERD_tree_1
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
enew
file __Tag_List__
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=9999
setlocal fml=0
setlocal fdn=20
setlocal fen
wincmd w
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
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 92 - ((24 * winheight(0) + 15) / 31)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
92
normal! 027|
wincmd w
argglobal
edit src/faqbot.cpp
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 333 - ((16 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
333
normal! 027|
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
let s:l = 12 - ((8 * winheight(0) + 8) / 16)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
12
normal! 016|
wincmd w
argglobal
edit faq.xml
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 25 - ((0 * winheight(0) + 16) / 32)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
25
normal! 091|
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
let s:l = 1 - ((0 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
4wincmd w
exe 'vert 1resize ' . ((&columns * 31 + 136) / 273)
exe 'vert 2resize ' . ((&columns * 29 + 136) / 273)
exe '3resize ' . ((&lines * 1 + 33) / 66)
exe 'vert 3resize ' . ((&columns * 147 + 136) / 273)
exe '4resize ' . ((&lines * 31 + 33) / 66)
exe 'vert 4resize ' . ((&columns * 147 + 136) / 273)
exe '5resize ' . ((&lines * 30 + 33) / 66)
exe 'vert 5resize ' . ((&columns * 147 + 136) / 273)
exe '6resize ' . ((&lines * 16 + 33) / 66)
exe 'vert 6resize ' . ((&columns * 63 + 136) / 273)
exe '7resize ' . ((&lines * 32 + 33) / 66)
exe 'vert 7resize ' . ((&columns * 63 + 136) / 273)
exe '8resize ' . ((&lines * 14 + 33) / 66)
exe 'vert 8resize ' . ((&columns * 63 + 136) / 273)
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
