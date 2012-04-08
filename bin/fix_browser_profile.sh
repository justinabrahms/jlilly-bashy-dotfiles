#!/bin/bash

if [ `which google-chrome` ]; then
  CHROME_NAME='google-chrome'
else
  CHROME_NAME='chromium'
fi

ps aux | grep google-chrome | awk '{ print $2 }' | xargs kill

CONFIG_HOME="$HOME/.config/$CHROME_NAME"
mv $CONFIG_HOME/{Default,Backup}
echo "Open Chrome, then close it, then do:\n\n"
echo "mv $CONFIG_HOME/{Backup,Default}"
