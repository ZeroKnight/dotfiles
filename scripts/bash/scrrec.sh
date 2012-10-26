#!/bin/bash
# scrrec.sh

# Simple script for Screen Recording

VIDPATH='/home/zeroknight/Videos/ScreenCapture'
cd $VIDPATH

# Get args
args=("$@")

# Syntax
if [ $# -eq 0 ]; then
    echo "Usage: scrrec [ [-f,--fullscreen] ] <filename>"
    exit 1
fi

# Set capture resolution parameters
# Fullscreen
if [[ ${args[0]} == "-f" || ${args[0]} == "--fullscreen" ]]; then
    RES=`xrandr -q | grep -e "Screen 0:" | cut -d, -f2 | awk '{print $2 "x" $4}'`
    POS='0,0'

# Select Window
else
    INFO=$(xwininfo -frame)
    RES=$(echo "$INFO" | grep -e "Height:" -e "Width:" | cut -d\: -f2 | tr "\n" " " | awk '{print $1 "x" $2}')
    POS=$(echo "$INFO" | grep "upper-left" | head -n 2 | cut -d\: -f2 | tr "\n" " " | awk'{print $1 "," $2}')
fi

# Fire up ffmpeg
ffmpeg -f alsa -ac 2 -i pulse -f x11grab -r 30 -s $RES -i :0.0+$POS -acodec pcm_s16le -threads 0 "${args[$(($#-1))]}"

# Echo what we've got
echo "$RES -i :0.0+$POS -acodec"
echo "$POS"
echo ">> $VIDPATH/${args[$(($#-1))]}"
