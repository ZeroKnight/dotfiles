#!/bin/bash

# refreshmirrors.sh
# Script to update the pacman mirrorlist using `reflector`
# Generally intended to be run in a cron job

### Options

# Path to mirrorlist file
MIRRORFILE='/etc/pacman.d/mirrorlist'

# Mirror protocol; 'http' or 'ftp'
MIRRORPROTOCOL='http'

# Sort mirrors by: score, delay, age, country, rate
MIRRORSORT='score'

MIRRORFILTERS='-f 10 -l 10'

### Execute
echo -n "Updating pacman mirrorlist, saving to: '${MIRRORFILE}' ..."

reflector --save $MIRRORFILE -p $MIRRORPROTOCOL --sort $MIRRORSORT $MIRRORFILTERS

if [ $? -eq 0 ]; then
    echo ' Done! Synchronizing...'
    pacman -Syy
    echo 'New mirrorlist:'
    cat $MIRRORFILE
    exit 0
else
    echo ' FAILED.'
    exit 1
fi
