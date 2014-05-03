"   _____                   __ __       _       __    __ _
"  /__  /  ___  _________  / //_/____  (_)___ _/ /_  / /( )_____
"    / /  / _ \/ ___/ __ \/ ,<  / __ \/ / __ `/ __ \/ __/// ___/
"   / /__/  __/ /  / /_/ / /| |/ / / / / /_/ / / / / /_  (__  )
"  /____/\___/_/   \____/_/ |_/_/ /_/_/\__, /_/ /_/\__/ /____/
"                         _           /____/
"                  _   __(_)___ ___  __________
"                 | | / / / __ `__ \/ ___/ ___/
"                _| |/ / / / / / / / /  / /__
"               (_)___/_/_/ /_/ /_/_/   \___/
"

" Stop living in the past. Be imProved
set nocompatible

" Initialize Plugins
source ~/.vim/vundle.vim

" The oh-so-essential Filetype! (now that Vundle is done)
"filetype plugin indent on
filetype plugin on

" Platform specific configuration
source ~/.vim/platform.vim

" Vim Settings
source ~/.vim/config.vim

" Plugin Configuration
source ~/.vim/plugins.vim

" Custom Commands
source ~/.vim/commands.vim

" Custom Mappings
source ~/.vim/mappings.vim

" Custom Functions
source ~/.vim/functions.vim

" Auto Commands
source ~/.vim/autocmds.vim

