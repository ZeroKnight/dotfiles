#
# Git aliases and utilities
#

### Settings

# Diff
set -g _git_diff_format_stat --stat --dirstat
set -g _git_diff_format_pstat --patch-with-stat --dirstat
set -g _git_diff_format_word --word-diff=color

### Aliases and abbreviations

# Basic
abbr -a g git
abbr -a gst git status
abbr -a gstv git status --long

# Fetch/Merge
abbr -a gf git fetch
abbr -a gp git push
abbr -a gpl git pull
abbr -a gm git merge

# Branch/Commit
abbr -a ga git add
abbr -a gA git add --patch
abbr -a gb git branch
abbr -a gc git commit
abbr -a gw git worktree

# Diff
abbr -a gd git diff
abbr -a gD git diff --staged

# Bang abbreviations for common diff options
abbr -a -c git -- !stat $_git_diff_format_stat
abbr -a -c git -- !pstat $_git_diff_format_pstat
abbr -a -c git -- !word $_git_diff_format_word

# Log
alias gl 'git log --all --graph --pretty=single'
alias glv 'git log --topo-order --pretty=fullinfo $_git_diff_format_stat'

# Stash
abbr -a gs git stash
abbr -a gsl git stash list
abbr -a gsd git stash show
abbr -a gsp git stash pop
abbr -a gS git stash --patch

# Shortcuts
abbr -a ghclone gh repo clone

function g.. --description 'Cd to or relative to git root'
    set -l root (git_root)
    if test -z "$root"
        echo 'error: not in a git repository'
        return 1
    end
    set -l target (string join '/' $root $argv[1])
    echo $target
    cd $target
end

### Utility functions

function in_git_directory --description 'Test if in any kind of git directory'
    contains true (command git rev-parse --is-inside-git-dir --is-bare-repository --is-inside-work-tree 2>/dev/null)
end

function git_branch_current --description 'Return name of git branch or symbolic reference'
    set -l ref (command git symbolic-ref --quiet --short HEAD 2>/dev/null)
    switch $status
        case 1
            set -l ref (command git rev-parse --short HEAD 2>/dev/null)
        case 128
            return
    end
    test -n "$ref"; and echo $ref
end

function git_root --description 'Return the root of the current Git repository'
    set -l root (git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$root"
        echo $root
    else
        return 1
    end
end
