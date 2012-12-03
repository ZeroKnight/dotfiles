#!/bin/bash

# alarm.sh

# Simple "alarm clock" using `moc` and `at`

# Default Sound
SOUND='/home/zeroknight/Music/Opeth/Morningrise/The\ Night\ And\ The\ Silent\ Water.mp3'

# Default Volume level (%)
VOLUME=40

# If moc isn't running, start it.
PID=$(pgrep -f mocp)
if [ -z "$PID" ]; then
    screen -d -m -S moc-alarm mocp
fi

# If atd.service isn't active, start it.
if [ 'active' != "$(systemctl is-active atd.service)" ]; then
    echo '[!] atd.service is not active'
    sudo systemctl start atd.service
fi

# Check arguments
if [ $# -lt 1 ]; then
    echo "Usage: alarm.sh <time> [<Volume>] [<Sound file>]"
    echo -e "\tSee 'man at' for acceptable <time> paramters"
    exit 1;
elif [ $# -lt 3 ]; then
    VOLUME=$2
elif [ $# -eq 3 ]; then
    VOLUME=$2
    SOUND=$3
fi
TIME=$1

# Set the alarm
echo "mocp -v ${VOLUME} -p ${SOUND}" | at ${TIME}
