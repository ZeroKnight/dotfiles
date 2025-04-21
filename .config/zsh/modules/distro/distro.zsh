#
# Distro-specific stuff
#

local distro=$(. /etc/os-release 2>/dev/null; print -n $ID)

case $distro {
    opensuse*)
        alias zypper='sudo zypper'
        alias zyp='zypper'
        export ZYPP_CURL2=1 # Newer, simplified CURL backend. Overrules ZYPP_MULTICURL
        export ZYPP_PCK_PRELOAD=1
        ;;
    arch)
        alias pacman='sudo pacman'
        ;;
    *ubuntu|debian)
        alias apt='sudo apt'
        alias aptg='sudo apt-get'
        alias aptc='sudo apt-cache'
        ;;
    fedora)
        alias dnf='sudo dnf'
        ;;
}
