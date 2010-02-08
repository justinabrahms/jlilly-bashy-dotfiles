#!/bin/bash

shopt -s dotglob # shows dots in file globbing

for i in *; do
ln -s `pwd`/$i $HOME/$i
done
rm $HOME/symlink_files.sh
