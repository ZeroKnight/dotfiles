#
# Distro-specific stuff
#

local distro=$(. /etc/os-release 2>/dev/null; print -n $ID)

case $distro {
    opensuse*)
        alias zypper='sudo zypper'
        alias zyp='zypper'
        export ZYPP_MULTICURL=0    # Don't use metalink/zsync stuff
        export ZYPP_MEDIANETWORK=1 # Use new multithreaded backend
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
