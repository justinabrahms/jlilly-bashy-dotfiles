#!/bin/bash
# via http://etano.net/2010/01/25/chromium-your-profile-could-not-be-opened-correctly/
pkill chrome
cd ~/.config/google-chrome
mv Default/ Backup/
echo "Open chrome. Close chrome. Then run.."
echo ""
echo "rm -rf ~/.config/google-chrome/Default/"
echo "cp -R ~/.config/google-chrome/{Backup,Default}"
