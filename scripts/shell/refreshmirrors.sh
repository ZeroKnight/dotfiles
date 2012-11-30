#!/bin/bash

# refreshmirrors.sh
# Script to update the pacman mirrorlist

### Options

# Path to mirrorlist file
FILE='/etc/pacman.d/mirrorlist'

# Mirror protocol; 'http' or 'ftp'
PROTOCOL='http'

# Sort mirrors by: score, delay, age, country, rate
SORT='score'

FILTERS='-f 10 -l 10'

### Execute
echo -n "Updating pacman mirrorlist, saving to: '${FILE}' ..."

reflector --save $FILE --sort $SORT $FILTERS

if [ $? -eq 0 ]; then
    echo ' Done!'
else
    echo ' FAILED.'
fi
