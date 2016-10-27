#
# Settings and Helpers for various file compression/archiving tools
#

### Aliases

# Use the parallelized versions of gzip and bzip2 as compression times are
# significantly faster
[[ $+commands[pigz] ]] && alias gzip='pigz' gunzip='unpigz'
[[ $+commands[pbzip2] ]] && alias bzip2='pbzip2' bunzip2='pbunzip2'

