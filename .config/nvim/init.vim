" ZeroKnight's init.vim
" ------------------------------------------------------------------------------

" Defines a variable if it hasn't already been defined. Especially useful for
" environment variables
function! s:SetDefault(name, default)
  if !exists(a:name)
    silent exec 'let ' . a:name . " = '" . a:default . "'"
  endif
endfunction

call s:SetDefault('$VIMFILES',    expand('~/.config/nvim'))
call s:SetDefault('$VIMDATA',     expand('~/.local/share/nvim'))
call s:SetDefault('$VIMSESSIONS', $VIMDATA.'/sessions')

" Plugin Configuration
source $VIMFILES/plugins.vim

" Vim Settings
source $VIMFILES/config.vim

" Platform specific configuration
source $VIMFILES/platform.vim

" Custom Commands
source $VIMFILES/commands.vim

" Custom Mappings
source $VIMFILES/mappings.vim

" Auto Commands
source $VIMFILES/autocmds.vim

