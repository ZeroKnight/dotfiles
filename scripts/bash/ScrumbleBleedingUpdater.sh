#!/bin/bash

# Quick 'n' Easy Linux x64 Bleeding Updater

# Location of Scrumblesihp
SCRUMDIR="/games/scrumbleship"

# Where you want to store Bleeding.zip and it's contents
BUILDDIR="/tmp/builds"

# Where Bleeding.zip resides after downloading
DOWNLOADDIR="$HOME/Downloads"

CODEDIR="$HOME/Documents/Coding/scrumbleship"

# Get args
args=("$@")

# Get architecture
# There's no *official* x86 Linux build of Scrumble yet
#if [ `uname -m` == 'x86_64' ]; then
    ARCH='64'
#else
#    ARCH='32'
#    ARCH=''
#fi

# Check to see if Scrumble is running
PID=$(pgrep -f scrumbleship${ARCH})
if [ ! -z $PID ]; then
    echo "[!] Scrumbleship is running! Close it first!"
    exit 3
fi

if [[ ${args[0]} == "-s" ]]; then
    echo 'Just updating dev src ...'
    cp -r $SCRUMDIR/src $CODEDIR
    if [ $? != 0 ]; then
        echo '[!] Could not copy src'
        exit 1
    fi
    echo 'Recreating tags file'
    cd src
    ctags -R
    echo 'Done. Dev src updated.'
    exit 0
fi

cd $DOWNLOADDIR

if [ -f Bleeding.zip ]; then
    # Make sure the build dir is actually there
    # If it's in /tmp, it may have been deleted at some point
    if [ ! -d $BUILDDIR ]; then
        mkdir -pv $BUILDDIR
        if [ $? != 0 ]; then
            echo '[!] Build dir was not found, and we could not create it.'
            exit 1
        fi
    fi

    mv Bleeding.zip $BUILDDIR
    if [ $? != 0 ]; then
        echo "[!] Couldn't move Bleeding.zip to build dir"
        exit 1
    fi

    cd $BUILDDIR
    echo "Extracting Bleeding.zip ..."
    unzip -qo Bleeding.zip

    echo "Updating binary ..."
    cd scrumbleship
    if [ -d config ]; then
        cp -r config src scrumbleship${ARCH} $SCRUMDIR
        if [ $? != 0 ]; then
            echo "[!] Couldn't copy bleeding files to game"
            exit 1
        fi
    else
        cp -r src scrumbleship${ARCH} $SCRUMDIR
        if [ $? != 0 ]; then
            echo "[!] Couldn't copy bleeding files to game"
            exit 1
        fi
    fi

# If Bleeding.zip isn't in Downloads, check for the files in the Build dir
else
    echo "[!] Bleeding.zip not found! Checking build dir ..."
    cd $BUILDDIR
    if [ -d scrumbleship ]; then
        echo "Found '$BUILDDIR/scrumbleship', using that ..."
        cd scrumbleship
        if [ -d config ]; then
            cp -r config src scrumbleship${ARCH} $SCRUMDIR
            if [ $? != 0 ]; then
                echo "[!] Couldn't copy bleeding files to game"
                exit 1
            fi
        else
            cp -r src scrumbleship${ARCH} $SCRUMDIR
            if [ $? != 0 ]; then
                echo "[!] Couldn't copy bleeding files to game"
                exit 1
            fi
        fi

# Check for the zip if we can't find "scrumbleship"
    elif [ -f Bleeding.zip ]; then
        echo "Found '$BUILDDIR/Bleeding.zip', using that ..."
        unzip -qo Bleeding.zip
        cd scrumbleship
        if [ -d config ]; then
            cp -r config src scrumbleship${ARCH} $SCRUMDIR
            if [ $? != 0 ]; then
                echo "[!] Couldn't copy bleeding files to game"
                exit 1
            fi
        else
            cp -r src scrumbleship${ARCH} $SCRUMDIR
            if [ $? != 0 ]; then
                echo "[!] Couldn't copy bleeding files to game"
                exit 1
            fi
        fi
    
# Scmething dun goofed
    else
        echo '[!] Bleeding Update not found!'
        exit 1
    fi
fi

# Check to see if we're actually updated and something crazy didn't happen
if [ -f "$SCRUMDIR/scrumbleship${ARCH}" ]; then
    echo 'Done!'
else
    echo "[!] Update failed: '$SCRUMDIR/scrumbleship${ARCH}' not found!"
    exit 2
fi

# Note the Bleeding number, for various future reference
read -p 'Bleeding Build number: ' REV
echo "$REV" > $SCRUMDIR/lastbleeding

# Src Update
echo 'New Src Files: '
ls $BUILDDIR/scrumbleship/src
read -sn 1 -p 'Merge new src files with dev src files? [yN] ' CHOICE
echo
if [ "${CHOICE}" != "y" ]; then
    echo 'No changes to dev src.'
else
    echo
    cp -r $BUILDDIR/scrumbleship/src $CODEDIR
    if [ $? != 0 ]; then
        echo '[!] Could not copy src'
        exit 1
    fi
    echo 'Recreating tags file'
    cd src
    ctags -R
    echo 'Done. Dev src updated.'
fi

# Cleanup
echo 'Cleaning up'
rm -r $BUILDDIR/scrumbleship $BUILDDIR/Bleeding.zip
