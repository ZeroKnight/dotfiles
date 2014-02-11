"   _____                   __ __       _       __    __ _
"  /__  /  ___  _________  / //_/____  (_)___ _/ /_  / /( )_____
"    / /  / _ \/ ___/ __ \/ ,<  / __ \/ / __ `/ __ \/ __/// ___/
"   / /__/  __/ /  / /_/ / /| |/ / / / / /_/ / / / / /_  (__  )
"  /____/\___/_/   \____/_/ |_/_/ /_/_/\__, /_/ /_/\__/ /____/
"               ____ __   __(_)___ ___/___________
"              / __ `/ | / / / __ `__ \/ ___/ ___/
"            _/ /_/ /| |/ / / / / / / / /  / /__
"           (_)__, / |___/_/_/ /_/ /_/_/   \___/
"            /____/


" Set a decent default window size
set lines=30
set columns=100

" Set guioptions
set guioptions=eimgt

" Font Settings
if has("win32")
    set guifont=Source_Code_Pro_Semibold:h10:cANSI
else
    set guifont=Source\ Code\ Pro\ Semibold\ 9
endif

" Set guitablabel
" ...after learning some vim scripting :)

" Select All
xnoremap  ggVG
snoremap  gggHG
onoremap  gggHG
nnoremap  gggHG

" Cut/Paste
cmap <S-Insert> +
imap <S-Insert> +
vmap <S-Insert> +
vnoremap <C-Insert> "+y
vnoremap  "+y
vnoremap  "+x
vnoremap <BS> d
