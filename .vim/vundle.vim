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

" UI Additions {{{
Plugin 'bling/vim-airline'
"Plugin 'scrooloose/nerdtree'
Plugin 'justinmk/vim-dirvish'
Plugin 'mhinz/vim-startify'
Plugin 'mbbill/undotree'
"Plugin 'sjl/gundo'
Plugin 'majutsushi/tagbar'
Plugin 'hari-rangarajan/CCTree'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/ShowMarks'
Plugin 'Yggdroot/indentLine'
"}}}

" Commands/Mappings {{{
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-characterize'
Plugin 'tpope/vim-commentary'
Plugin 'godlygeek/tabular'
" Plugin 'scrooloose/nerdcommenter'
Plugin 'christoomey/vim-sort-motion'
Plugin 'wellle/targets.vim'
Plugin 'moll/vim-bbye'
"Plugin 'Lokaltog/vim-easymotion'
"}}}

" Helpers {{{
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'SirVer/ultisnips'
Plugin 'rking/ag.vim'
Plugin 'xolox/vim-session'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bruno-/vim-man'
Plugin 'alx741/vinfo'
Plugin 'reedes/vim-wordy'
"}}}

" Color Schemes {{{
"Plugin 'vim-scripts/CSApprox'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Pychimp/vim-luna'
Plugin 'tomasr/molokai'
Plugin 'briancarper/gentooish.vim'
Plugin 'ciaranm/inkpot'
Plugin 'nanotech/jellybeans.vim'
Plugin 'vim-scripts/lettuce.vim'
Plugin 'vim-scripts/Liquid-Carbon'
Plugin 'vim-scripts/rdark'
Plugin 'vim-scripts/Sorcerer'
Plugin 'vim-scripts/werks.vim'
"}}}

" Language Additions/Extensions {{{
Plugin 'othree/xml.vim'
Plugin 'Valloric/MatchTagAlways'
Plugin 'jeaye/color_coded'
"Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'withgod/vim-sourcepawn'
"}}}

" Syntax Files {{{
"Plugin 'ZeroKnight/vim-cubescript'
Plugin 'plasticboy/vim-markdown'
Plugin 'mutewinter/vim-tmux'
"Plugin 'mutewinter/nginx.vim'
Plugin 'kurayama/systemd-vim-syntax'
Plugin 'xolox/vim-lua-ftplugin'
"}}}

" Libraries/APIs {{{
Plugin 'tpope/vim-repeat'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-dispatch'
"}}}

" vim: fdm=marker
