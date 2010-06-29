#!/bin/bash

shopt -s dotglob # shows dots in file globbing

for i in *; do
  rm $HOME/$i 2>/dev/null # remove duplicates
  ln -s `pwd`/$i $HOME/$i # copy new files in
done

# Clean up after our naieve loop
rm $HOME/symlink_files.sh
rm -rf $HOME/.git

echo "Symlinking successful."
