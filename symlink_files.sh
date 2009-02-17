#!/bin/bash

shopt -s dotglob # shows dots in file globbing

for i in *; do
ln -s `pwd`/$i `pwd`/../$i
done
rm ../symlink_files.sh
