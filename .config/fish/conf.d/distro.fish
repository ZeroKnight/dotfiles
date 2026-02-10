#
# Distro-specific stuff
#

set -l distro (awk -F= '/^ID=/ { print $2 }' /etc/os-release | string trim -c '"')

switch $distro
    case 'opensuse*'
        abbr -a zyp zypper
    case ubuntu debian
        abbr -a aptg apt-get
        abbr -a aptc apt-cache
end
