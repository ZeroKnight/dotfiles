#
# Atuin configuration
#

command -q atuin; or return

# TBD: keybinds
set -gx ATUIN_NOBIND true

atuin init fish | source
