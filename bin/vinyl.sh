#!/bin/bash

# Simple utility for use on my home media server which will link the
# record player input with the speakers for output. Not sure if there
# is a good way of dynamically figuring out what the correct input and
# output are, but this works well enough for now.
#
# Taken from http://ubuntuforums.org/showthread.php?t=1316661

SERVICE='pacat'
 
if ps ax | grep -v grep | grep $SERVICE > /dev/null
then
    killall pacat
else
    pacat -r -d alsa_input.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00-CODEC.analog-stereo | pacat -p -d alsa_output.pci-0000_00_0f.1.analog-stereo
fi

