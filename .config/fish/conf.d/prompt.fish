#
# Prompt definition and settings
#

set -l prompt_title 'Zero Prompt (Fish Edition)'
set -l color_symbol green

# Settings for fish_git_prompt
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_showdirtystate true
set -g __fish_git_prompt_showuntrackedfiles true # can be disabled per-repo with bash.showUntrackedFiles
set -g __fish_git_prompt_showupstream auto informative
set -g __fish_git_prompt_showstashstate false
set -g __fish_git_prompt_shorten_branch_len 20
set -g __fish_git_prompt_describe_style branch

set -g __fish_git_prompt_showcolorhints true
set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_color_branch_detached red
set -g __fish_git_prompt_color_bare yellow
set -g __fish_git_prompt_color_merging cyan
set -g __fish_git_prompt_color_upstream magenta

set -g __fish_git_prompt_char_cleanstate
set -g __fish_git_prompt_char_stagedstate 
set -g __fish_git_prompt_char_dirtystate +
set -g __fish_git_prompt_char_invalidstate !
set -g __fish_git_prompt_char_untrackedfiles …
set -g __fish_git_prompt_char_upstream_ahead 
set -g __fish_git_prompt_char_upstream_behind 
set -g __fish_git_prompt_char_upstream_diverged 󰹹

function fish_prompt --description $prompt_title -V color_symbol
    # NOTE: Need to capture last (pipe)status here, otherwise it will be
    # clobbered on exit from this and subsequent prompt_* functions.
    set -g __zero_prompt_last_status $status
    set -g __zero_prompt_last_pipestatus $pipestatus

    if fish_is_root_user
        set suffix '#'
        set color_suffix red
    else
        set suffix '%'
        set color_suffix $color_symbol
    end

    set -l segment_head "$(set_color $color_symbol)::$(set_color normal)"
    set -l segment_tail "$(set_color $color_suffix)$suffix$(set_color normal)"

    echo -n -s "$segment_head " (prompt_login) " $segment_tail "
end

function fish_right_prompt --description "Right $prompt_title"
    set -l rpad 1
    set -l segment_rhead "$(set_color blue)❮$(set_color brblue)❮$(set_color normal)"

    echo -n -s "$segment_rhead " (prompt_pwd) (fish_vcs_prompt) ' '(prompt_status) (string repeat -N $rpad ' ')
end

function prompt_login --description "Login segment for $prompt_title" -V color_symbol
    if fish_is_root_user
        set color_user red
    else
        set color_user $fish_color_user
    end

    if set -q SSH_TTY
        set color_host $fish_color_host_remote
    else
        set color_host $fish_color_host
    end

    echo -n -s (set_color $color_user) "$USER" (set_color $color_symbol) @ (set_color $color_host) (prompt_hostname) (set_color normal)
end

function prompt_pwd --description "CWD segment for $prompt_title"
    set -l path $PWD

    # If in a subdirectory of a git repository, shorten the path to start at the git root
    if in_git_directory
        set -l root (git_root)
        set -l root_name (path basename $root)
        set -l subpath (string replace $root '' (realpath $path))
        if test -n "$subpath"
            set path "$root_name$subpath"
        end
    end
    set -l homedir (string escape --style=regex -- ~)
    set path (string replace -r "^$homedir(\$|/)" '~$1' $path)

    echo -n -s (set_color $fish_color_cwd) $path (set_color normal)
end

# Mostly taken from the default fish_prompt and modified a bit
function prompt_status --description "Status segment for $prompt_title"
    set -l last_pipestatus $__zero_prompt_last_pipestatus
    set -lx __fish_last_status $__zero_prompt_last_status # Export for __fish_print_pipestatus

    test -n "$fish_color_status"; or set -g fish_color_status red
    test -n "$fish_color_status_unchanged"; or set -g fish_color_status_unchanged $fish_color_status
    set -l status_color $fish_color_status

    # Show initial status differently in subsequent prompts if it hasn't
    # changed, e.g. background jobs or running `set` on its own.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
        set status_color $fish_color_status_unchanged
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_symbol "$(set_color $status_color)󰌑 "

    echo -n -s (__fish_print_pipestatus '[' ']' '|' (set_color $status_color) (set_color $bold_flag $status_color) $last_pipestatus)$status_symbol (set_color normal)
end
