#!/usr/bin/perl -w
use strict;
use warnings;

my $searchPath = '~/Dropbox/wallpapers/';   # Set to the directory you want to have searched for photos
my $switchTime = 30*60; # 30 min

# bgotd-- background of the day  
# Written by Michael Moore, Nov. 2007, placed in the public domain 

my @photos = `find $searchPath -type f`;
chomp(@photos);
my $photo;

while(1)
{
    $photo = $photos[rand($#photos)];
    `gconftool-2 --type string --set /desktop/gnome/background/picture_filename "$photo"`;
    sleep($switchTime);
}
