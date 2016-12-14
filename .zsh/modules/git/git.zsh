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

# Branch
alias gb='git branch'
alias gbc='git checkout -b'
alias gbl='git branch -vv'
alias gbL='git branch -avv'
alias gbx='git branch -d'
alias gbX='git branch -D'
alias gbm='git branch -m'
alias gbM='git branch -M'
alias gbs='git show-branch'
alias gbS='git show-branch -a'
alias gco='git checkout'
alias gcO='git checkout --patch'
alias gcod='git checkout --detach'
alias gcom='git checkout master'

# Commit
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias gcm='git commit --message'
alias gcam='git commit --all --message'
alias gcf='git commit --amend --reuse-message HEAD'
alias gcF='git commit --amend --verbose'
alias gcp='git commit --patch'
alias gcr='git revert'
alias gsh='git show'

# Fetch/Pull/Clone
alias gf='git fetch'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gcl='git clone'

# Index
alias ga='git add'
alias gA='git add --patch'
alias gau='git add --update'
alias gd='git diff $=_git_diff_normal_format'
alias gD='git diff --cached $=_git_diff_normal_format'
alias gdw='git diff $=_git_diff_word_format'
alias gDw='git diff --cached $=_git_diff_word_format'
alias gir='git reset'
alias gu='git reset --' # u -> unstage
alias giR='git reset --patch'
alias gix='git rm -r --cached'
alias giX='git rm -rf --cached'

# Log
alias gl='git log --all --graph --pretty=single'
alias glv='git log --topo-order --stat --dirstat --pretty=fullinfo'
alias gld='git log --topo-order --patch-with-stat --full-diff --pretty=medinfo'
alias glS='git log --topo-order --patch-with-stat --full-diff --pretty=medinfo -S'
alias glG='git log --topo-order --patch-with-stat --full-diff --pretty=medinfo -G'

# Merge
alias gm='git merge'
alias gma='git merge --abort'
alias gmt='git mergetool'

# Push
alias gp='git push'
alias gP='git push --force'
alias gpa='git push --all'
alias gpA='git push --all && git push --tags'
alias gpt='git push --tags'
alias gpu='git push --set-upstream origin'
alias gpc='git push --set-upstream origin $(git_branch_current 2>/dev/null)'

# Rebase
alias gre='git rebase'
alias grei='git rebase --interactive'

# Remote
alias gr='git remote'
alias grl='git remote --verbose'
alias gra='git remote add'
alias grx='git remote rm'
alias grX='git remote prune'
alias grm='git remote rename'
alias gru='git remote update'
alias grs='git remote show'

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
alias gssi='git stash save --keep-index'

# Submodule
alias gS='git submodule'
alias gSa='git submodule add'
alias gSf='git submodule foreach'
alias gSi='git submodule init'
alias gSI='git submodule update --init --recursive'
alias gSl='git submodule status'
alias gSs='git submodule sync'
alias gSu='git submodule foreach git pull origin master'
alias gSx='git-submodule-remove'

# Tag
alias gt='git tag'
alias gtv='git verify-tag'

# Working Tree
alias gst='git status --short --branch'
alias gstv='git status --long'
alias gwc='git clean -n'
alias gwC='git clean -di'
alias gwx='git rm -r'
alias gwX='git rm -rf'
