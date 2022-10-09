#
# Zsh Completion Settings
#

autoload -U is-at-least

# XXX: There's got to be a better (modular) way
# Load extra compdefs
source ${0:h}/compdefs.zsh

### Zsh completion options

setopt always_to_end
setopt auto_list auto_menu no_menu_complete
setopt auto_param_slash
setopt auto_param_keys
setopt complete_in_word

setopt case_glob case_match
setopt extended_glob

is-at-least '5.2' && setopt glob_star_short

### zstyles - Fine tune completion

# General Completer settings
zstyle ':completion:*' completer _extensions _expand _complete _ignored _match _approximate
zstyle ':completion:predict:*' completer _complete
zstyle ':completion::approximate:*' max-errors 3 numeric
zstyle ':completion::(match|approximate):*' insert-unambiguous true
zstyle ':completion::expand:*' accept-exact true
zstyle ':completion::expand:*' add-space file subst
zstyle ':completion::expand:*' group-name ''
zstyle ':completion::expand:*' group-order all-expansions expansions original
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:*:*:*' single-ignored menu
zstyle ':completion::complete:*' use-cache true
zstyle ':completion::complete:*' cache-path "$ZCACHEDIR/zcompcache"

# Matcher - Case insensitive, then partial-word completion, then substring
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Formatting
zstyle ':completion:*:options' description true
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*' list-separator '|'
zstyle ':completion:*' format ' %F{green}> > %d%f'
zstyle ':completion:*:messages' format ' %F{magenta}> > %d%f'
zstyle ':completion:*:warnings' format ' %F{red}> > no matches found!%f'
zstyle ':completion:*:(approximate|correct)' format ' %F{yellow}> > %d for %B%o%b (errors: %e)%f'
zstyle ':completion:*:*expansions' format ' %F{cyan}> > %d for %B%o%b%f'
zstyle ':completion:*:default' list-prompt '%S%m matches | line %l | %p%s'
zstyle ':completion:*:default' select-prompt '%S%m matches | line %l | %p%s'

# Ignored Patterns
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.zwc' 'tags'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:users' ignored-patterns avahi bin colord daemon dbus ftp git 'gpm(-root)?' http mail nobody polkitd sshd 'systemd-*' uuidd

# Ignore duplicate elements
zstyle ':completion:*:(rm|kill|*diff):*' ignore-line other

# Behavior
# Group builtins with external commands to condense
zstyle ':completion:*:*:-command-:*:*' group-name ''
zstyle ':completion:*:*:-command-:*:builtins' group-name 'commands'
zstyle ':completion:*:*:-command-:*:*' group-order functions aliases commands

# Only complete parameters we're completing at a $ in a subscript
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directories
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:-tilde-:*' group-name ''
zstyle ':completion:*:*:-tilde-:*' group-order users named-directories
zstyle ':completion:*:*:-tilde-:*' tag-order 'users named-directories'

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
