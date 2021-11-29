#
# Git Configuration
#
# Thanks to Sorin Ionescu for most of these nice aliases

### Settings

# Diff
_git_diff_normal_format='--patch-with-stat --dirstat'
_git_diff_word_format="$_git_diff_normal_format --word-diff=color"

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
alias gc='git commit --verbose'

# Diff
alias gd='git diff $=_git_diff_normal_format'
alias gD='git diff --cached $=_git_diff_normal_format'
alias gdw='git diff $=_git_diff_word_format'
alias gDw='git diff --cached $=_git_diff_word_format'

# Log
alias gl='git log --all --graph --pretty=single'
alias glv='git log --topo-order --stat --dirstat --pretty=fullinfo'

# Stash
alias gs='git stash'
alias gsa='git stash apply'
alias gsb='git stash branch'
alias gsx='git stash drop'
alias gsl='git stash list'
alias gsd='git stash show $_git_diff_normal_format'
alias gsdw='git stash show $_git_diff_word_format'
alias gsp='git stash pop'
alias gss='git stash save'
alias gsS='git stash save --patch'
