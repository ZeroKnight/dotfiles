#
# Zsh Completion Settings
#

autoload -U is-at-least

# XXX: There's got to be a better (modular) way
# Load extra compdefs
source ${0:h}/compdefs.zsh

# Zsh completion options

setopt always_to_end complete_in_word
setopt auto_list auto_menu no_menu_complete
setopt auto_param_slash auto_param_keys auto_remove_slash

setopt case_glob case_match
setopt extended_glob

is-at-least '5.2' && setopt glob_star_short

#
# zstyles - Fine tune completion
#

# NOTE: zstyle always prefers to match the most specific context pattern.
#
# A context pattern is considered "more specific" than another pattern when:
#   1. It contains more fields
#   2. The component patterns in each field are more specific
#
# Component patterns are more specific than another when:
#   1. It is a simple string
#   2. It is a complex pattern
#   3. It is a single `*` wildcard
#
# See also the `zstyle` section of zshmodules(1), zshcompsys(1), zshguide06, and
# the Completion-System doc.

# NOTE: I could be wrong, but I don't believe an empty field is the same as a
# lone wildcard. A completer may not provide a value for a given field in all
# contexts, like _approximate.

### General Completer settings

# NOTE: Do not bind `expand-or-complete` when using the _expand completer
zstyle ':completion:*' completer _extensions _expand _complete _prefix _ignored _match _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' single-ignored menu
zstyle ':completion:*' show-completer true

# Matcher - Case insensitive, then partial-word completion, then substring
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

### Complete

zstyle ':completion::complete:*' use-cache true
zstyle ':completion::complete:*' cache-path "$ZCACHEDIR/zcompcache"

# Don't auto-accept ambiguous matches that happened to be exactly correct
zstyle ':completion::complete:*' accept-exact false

### Approximate

# Skip menu selection if the correction is unambiguous with only a single error
zstyle ':completion::approximate:*' max-errors 3 numeric
zstyle ':completion::(approximate|correct)-1:*' insert-unambiguous true
zstyle ':completion::(approximate|correct|match):*' insert-unambiguous false

### Expand

zstyle ':completion::expand:*' add-space file subst

# Allow both completion and expansion of parameter names
#
# The _expand completer allows this via `accept-exact continue`, which will
# continue to the next completer (should be _complete). Since two completers
# are invoked, getting the group naming and contexts right is tricky: we have
# set `group-name` for parameters in the context of _complete.
zstyle ':completion::expand:*' accept-exact continue
zstyle ':completion::expand:*' group-name ''
zstyle ':completion::complete:-parameter-:*' group-name ''
zstyle ':completion::expand:*' group-order parameters all-expansions expansions original

### Prefix

zstyle ':completion::prefix:*' add-space true

### Formatting

zstyle ':completion:*:options' description true
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*' list-separator '|'

zstyle ':completion:*' format ' %F{green}> > %d%f'
zstyle ':completion::match:*' format ' %F{blue}> > matches for %d%f'
zstyle ':completion::match:*:original' format ' %F{green}> > %d%f'
zstyle ':completion:*:messages' format ' %F{magenta}> > %d%f'
zstyle ':completion:*:warnings' format ' %F{red}> > no matches found!%f'
zstyle ':completion:*:corrections' format ' %F{yellow}> > %d for %B%o%b (errors: %e)%f'
zstyle ':completion:*:(all-)?expansions' format ' %F{cyan}> > %d for %B%o%b%f'
zstyle ':completion:*:default' list-prompt '%S%m matches | line %l | %p%s'
zstyle ':completion:*:default' select-prompt '%S%m matches | line %l | %p%s'

### Result Filtering

# Ignored Patterns
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.zwc' 'tags'
zstyle ':completion:*:users' ignored-patterns avahi bin colord daemon dbus ftp git 'gpm(-root)?' http mail nobody polkitd sshd 'systemd-*' uuidd

# Ignore duplicate elements
zstyle ':completion:*:(rm|kill|*diff):*' ignore-line other

# Only complete prefixed functions when a `_` or `.` is explicitly given
zstyle ':completion:*:functions' prefix-needed true

### Context-specific Behaviors

# Group builtins with external commands to condense output
zstyle ':completion:*:*:-command-:*:*' group-name ''
zstyle ':completion:*:*:-command-:*:builtins' group-name 'commands'
zstyle ':completion:*:*:-command-:*:*' group-order functions aliases commands

# Only complete parameters when we're completing at a $ in a subscript
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directories
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:-tilde-:*' group-name ''
zstyle ':completion:*:*:-tilde-:*' group-order users named-directories
zstyle ':completion:*:*:-tilde-:*' tag-order 'users named-directories'

# Allow completing `..` in path contexts only when it's the current prefix
# NOTE: The `#` in the pattern below is part of filename generation
zstyle -e ':completion:*:paths' special-dirs \
    '[[ $PREFIX = (../)#(|..) ]] && reply=(..)'

# Use menu selection when the list of matches fits on screen, otherwise use
# menu completion to prevent scrolling
zstyle ':completion:*:*:cd:*:directory-stack' menu true=long select

# Processes
zstyle ':completion:*:*:kill:*' group-name ''
zstyle ':completion:*:*:kill:*' group-order processes process-groups
zstyle ':completion:*:*:kill:*' tag-order 'processes process-groups'
zstyle ':completion:*:jobs' list-colors 'no=34'
zstyle ':completion:*:processes' list-colors "=* $USER *=32"
zstyle ':completion:*:processes' command "ps -e"
zstyle ':completion:*:*:kill:*:processes' command "ps -u $USER"

# History
zstyle ':completion:history-words:*' stop true
zstyle ':completion:history-words:*' list false
zstyle ':completion:history-words:*' remove-all-dups true

# Man Pages
zstyle ':completion:*:manuals.*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
