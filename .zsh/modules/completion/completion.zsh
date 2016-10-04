#
# Zsh Completion Settings
#

# Explicitly load complist to ensure menu-select can be re-defined by compinit
zmodload zsh/complist

# Load and initialize the completion system
# $fpath MUST be set up BEFORE running compinit!
autoload -Uz compinit && compinit

# XXX: There's got to be a better (modular) way
# Load extra compdefs
source ${0:h}/compdefs.zsh

# Compile .zcompdump in the background
{ zcompare $ZDOTDIR/.zcompdump } &!

### Zsh completion options

setopt always_to_end
setopt auto_list auto_menu no_menu_complete

setopt case_glob case_match
setopt extended_glob
setopt glob_star_short

# When Tab-completing a pattern, all matches are placed into a completion menu
# instead of being inserted into the current command line
#setopt glob_complete

### zstyles - Fine tune completion

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'

