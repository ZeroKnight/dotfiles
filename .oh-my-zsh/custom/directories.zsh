alias df='df -h'    # Human-readable
alias du='du -ch'   # Human-readable; total

###
### ls Shortcuts
###

alias ls='ls -hAF --color'  # Baseline
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

