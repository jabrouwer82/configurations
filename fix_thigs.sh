#!/usr/bin/bash
synclient VertScrollDelta=-58
synclient HorizScrollDelta=-58
synclient RightButtonAreaLeft=0
synclient RightButtonAreaTop=0

#xinput set-prop "Logitech USB Trackball" "Device Accel Constant Deceleration" .45

setxkbmap -option caps:escape

#sudo rmmod pcspkr

stty -ixon
