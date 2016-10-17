"   _____                   __ __       _       __    __ _
"  /__  /  ___  _________  / //_/____  (_)___ _/ /_  / /( )_____
"    / /  / _ \/ ___/ __ \/ ,<  / __ \/ / __ `/ __ \/ __/// ___/
"   / /__/  __/ /  / /_/ / /| |/ / / / / /_/ / / / / /_  (__  )
"  /____/\___/_/   \____/_/ |_/_/ /_/_/\__, /_/ /_/\__/ /____/
"                                     /____/
"               _    __                ____
"              | |  / /_  ______  ____/ / /__
"              | | / / / / / __ \/ __  / / _ \
"              | |/ / /_/ / / / / /_/ / /  __/
"              |___/\__,_/_/ /_/\__,_/_/\___/
"

filetype off " Required by Vundle (temporarily)

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Let Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" Plugin Bundles
"================

" Menus, UI Tweaks & Additions {{{
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'scrooloose/nerdtree'
Plugin 'justinmk/vim-dirvish'
Plugin 'mhinz/vim-startify'
Plugin 'mbbill/undotree'
Plugin 'majutsushi/tagbar'
Plugin 'hari-rangarajan/CCTree'
Plugin 'airblade/vim-gitgutter'
Plugin 'kshenoy/vim-signature'
Plugin 'Yggdroot/indentLine'
Plugin 'chrisbra/NrrwRgn'
"}}}

" Commands/Mappings {{{
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-characterize'
Plugin 'tpope/vim-commentary'
Plugin 'godlygeek/tabular'
Plugin 'christoomey/vim-sort-motion'
Plugin 'wellle/targets.vim'
Plugin 'moll/vim-bbye'
"}}}

" Helpers & Tools {{{
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'SirVer/ultisnips'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-obsession'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bruno-/vim-man'
Plugin 'alx741/vinfo'
Plugin 'reedes/vim-wordy'
Plugin 'wesQ3/vim-windowswap'
Plugin 'Konfekt/FastFold'
"}}}

" Syntax Files & Language Additions/Extensions {{{
Plugin 'sheerun/vim-polyglot'
Plugin 'othree/xml.vim'
Plugin 'Valloric/MatchTagAlways'
Plugin 'jeaye/color_coded'
"Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'ZeroKnight/vim-cubescript'
Plugin 'xolox/vim-lua-ftplugin'
Plugin 'withgod/vim-sourcepawn'
"}}}

" Libraries/APIs {{{
Plugin 'tpope/vim-repeat'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-dispatch'
"}}}

" Color Schemes {{{
Plugin 'joshdick/onedark.vim'
Plugin 'Pychimp/vim-luna'
Plugin 'tomasr/molokai'
Plugin 'sickill/vim-monokai'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ciaranm/inkpot'
Plugin 'nanotech/jellybeans.vim'
"}}}

" vim: fdm=marker
