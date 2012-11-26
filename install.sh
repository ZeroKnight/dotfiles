#!/bin/bash

# "Installer" for ZeroKnight's dotfiles
# Intended to be run via:
#   curl -Ss https://github.com/ZeroKnight/dotfiles/install.sh | sh

DOTDIRS="\
$HOME/.config/openbox
$HOME/.config/tint2
$HOME/.vim
$HOME/scripts"

DOTFILES="\
$HOME/.config/compton.conf
$HOME/.conkyrc
$HOME/.gvimrc
$HOME/.vimrc
$HOME/.vimrc_funcitons
$HOME/.xinitc
$HOME/.zshrc"

### Splash ########################
echo -e "\n--- Grabbing ZeroKnight's Dotfiles... ---\n"

### Clone the Repo ################
git clone git://github.com/ZeroKnight/dotfiles.git ~/dotfiles

### Backup existing dotfiles ######
### Create symlinks ###############
echo -e "\n--- Symlinking Dotdirs... ---\n"
for d in $DOTDIRS; do
    if [ -d $d ]; then
        mv $d ${d}.nongit
        echo "[!] $d backed up as ${d}.nongit"
    fi

#ln -s $d $(echo "$d" | sed 's/\//\/dotfiles\//')
done

echo -e "\n--- Symlinking Dotfiles... ---\n"
for f in $DOTFILES; do
    if [ -e $f ]; then
        mv $f ${f}.nongit
        echo "[!] $f backed up as ${f}.nongit"
    fi

#ln -s $f $(echo "$f" | sed 's/\//\/dotfiles\//')
done

### Update submodules #############
echo -e "\n--- Updating submodules... ---\n"
git --git-dir="~/dotfiles" submodule init
git --git-dir="~/dotfiles" submodule update

### Farewell! #####################
echo -e "\n--- Dotfiles Installation done! ---"
