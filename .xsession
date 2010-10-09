#!/bin/sh
if [ -f $HOME/.Xdefaults ]; then
    xrdb -merge $HOME/.Xdefaults
fi
if [ ! `pidof nm-applet` ]; then
    nm-applet & 1>/dev/null 2>/dev/null
fi

xmodmap ~/.xmodmap
