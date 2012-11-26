#!/bin/bash

# "Installer" for ZeroKnight's dotfiles
# Intended to be run via:
#   curl -Ss https://github.com/ZeroKnight/dotfiles/install.sh | sh

DOTDIRS="\
.config/openbox
.config/tint2
.vim
scripts"

DOTFILES="\
.config/compton.conf
.conkyrc
.gvimrc
.vimrc
.vimrc_funcitons
.xinitc
.zshrc"

cd $HOME

### Splash ########################
echo -e "\n--- Grabbing ZeroKnight's Dotfiles... ---\n"

### Clone the Repo ################
git clone git://github.com/ZeroKnight/dotfiles.git dotfiles

### Backup existing dotfiles ######
### Create symlinks ###############
echo -e "\n--- Symlinking Dotdirs... ---\n"
for d in $DOTDIRS; do
    if [ -d $d ]; then
        mv $d ${d}.nongit
        echo "[!] $d backed up as ${d}.nongit"
    fi

    ln -s $HOME/dotfiles/$d ${HOME}/$d
done

echo -e "\n--- Symlinking Dotfiles... ---\n"
for f in $DOTFILES; do
    if [ -e $f ]; then
        mv $f ${f}.nongit
        echo "[!] $f backed up as ${f}.nongit"
    fi

    ln -s ${HOME}/dotfiles/$f ${HOME}/$f
done

### Update submodules #############
echo -e "\n--- Updating submodules... ---\n"
git --git-dir="dotfiles" submodule init
git --git-dir="dotfiles" submodule update

### Farewell! #####################
echo -e "\n--- Dotfiles Installation done! ---"
