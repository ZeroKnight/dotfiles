#
# Directory settings, aliases and functions
#

### dircolors

# Set LS_COLORS
eval $(dircolors -b $HOME/.config/.dircolors)

# Enable dircolors in file completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

### Zsh options

# Automatic directory stack management
setopt auto_pushd pushd_ignore_dups pushdminus

# cd Modifications
setopt auto_cd # `foo` == `[-d 'foo'] && cd foo`
setopt cdable_vars

### Aliases

# Directory Aliases
alias df='df -h'  # Human-readable
alias du='du -ch' # Human-readable; total
alias md='mkdir -vp'
alias rd='rmdir'

# Directory Stack Shortcuts
alias pu='pushd'
alias po='popd'
alias -- -='cd -'

# ls Shortcuts
alias ls='ls -hAFH --color --group-directories-first'
alias ll='ls -l'            # Long-list
alias lr='ls -R'            # Recursive
alias lx='ls -BX'           # Sort by Extension, omit backups
alias lz='ls -S'            # Sort by Size
alias lt='ls -t'            # Sort by MTime
alias lc='ls -c'            # Sort by CTime
alias llr='ll -R'           # Long Recursive
alias llx='ll -BX'          # Long Sort by Extension
alias llz='ll -S'           # Long Sort by Size
alias llt='ll -t'           # Long Sort by MTime
alias llc='ll -c'           # Long Sort by CTime

# Reverse sort
alias lX='lx -r'            # Sort by Extension, omit backups, reverse
alias lZ='lz -r'            # Sort by Size, reverse
alias lT='lt -r'            # Sort by MTime, reverse
alias lC='lc -r'            # Sort by CTime, reverse
alias llX='llx -r'          # Long Sort by Extension, reverse
alias llZ='llz -r'          # Long Sort by Size, reverse
alias llT='llt -r'          # Long Sort by MTime, reverse
alias llC='llc -r'          # Long Sort by CTime, reverse

alias lss='ls | less'
alias lls='ll | less'

