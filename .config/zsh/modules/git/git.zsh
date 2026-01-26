#
# Git Configuration
#
# Thanks to Sorin Ionescu for most of these nice aliases

### Settings

# Diff
_git_diff_format_stat='--stat --dirstat'
_git_diff_format_pstat='--patch-with-stat --dirstat'
_git_diff_format_word="$_git_diff_normal_format --word-diff=color"

### Aliases

alias g='git'
alias g..='cd $(git_root || print .)'

alias gst='git status'
alias gstv='git status --long'

alias gf='git fetch'
alias gp='git push'
alias gpl='git pull'
alias gm='git merge'

alias ga='git add'
alias gA='git add --patch'
alias gb='git branch'
alias gc='git commit'

# Diff
alias gd='git diff $=_git_diff_format_pstat'
alias gD='git diff --cached $=_git_diff_format_pstat'
alias gdw='git diff $=_git_diff_format_word'
alias gDw='git diff --cached $=_git_diff_format_word'

# Log
alias gl='git log --all --graph --pretty=single'
alias glv='git log --topo-order --pretty=fullinfo $=_git_diff_format_stat'

# Stash
alias gs='git stash'
alias gS='git stash --patch'
alias gsl='git stash list'
alias gsd='git stash show'
alias gsdw='git stash show $=_git_diff_format_word'
alias gsp='git stash pop'
