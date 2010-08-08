#!/bin/bash

# imgur script by Bart Nagel <bart@tremby.net>
# version 2
# I release this as public domain. Do with it what you will.

# Required: curl
#
# Optional: xsel or xclip for automatically putting the URL on the X selection
# for easy pasting
#
# Instructions:
# Put it somewhere in your path and maybe rename it:
# 	mv ~/Downloads/imgur.sh ~/bin/imgur
# Make it executable:
# 	chmod +x ~/bin/imgur
# Stick your API key in the top:
# 	vim ~/bin/imgur
# Upload an image:
# 	imgur images/hilarious/manfallingover.jpg
# The URL will be displayed (and the delete page's URL will be displayed on
# stderr). If you have xsel or xclip the URL will also be put on the X
# selection, which you can usually paste with a middle click.

# API Key provided by Alan@imgur.com
apikey="b3625162d3418ac51a9ee805b1840452"

# function to output usage instructions
function usage {
	echo "Usage: $(basename $0) <filename>
Upload an image to imgur and output its new URL to stdout. Its delete page is
output to stderr.
If xsel or xclip is available, the URL is put on the X selection for easy
pasting." >&2
}

# check API key has been entered
if [ "$apikey" = "Your API key" ]; then
	echo "You first need to edit the script and put your API key in the variable near the top." >&2
	exit 15
fi

# check arguments
if [ "$1" = "-h" -o "$1" = "--help" ]; then
	usage
	exit 0
elif [ $# -ne 1 ]; then
	if [ $# == 0 ]; then
		echo "No file specified" >&2
	else
		echo "Unexpected arguments" >&2
	fi
	usage
	exit 16
elif [ ! -f "$1" ]; then
	echo "File \"$1\" not found" >&2
	exit 1
fi

# check curl is available
which curl >/dev/null 2>/dev/null || {
	echo "Couln't find curl, which is required." >&2
	exit 17
}

# upload the image
response=$(curl -F "key=$apikey" -H "Expect: " -F "image=@$1" \
	http://imgur.com/api/upload.xml 2>/dev/null)
# the "Expect: " header is to get around a problem when using this through the
# Squid proxy. Not sure if it's a Squid bug or what.
if [ $? -ne 0 ]; then
	echo "Upload failed" >&2
	exit 2
elif [ $(echo $response | grep -c "<error_msg>") -gt 0 ]; then
	echo "Error message from imgur:" >&2
	echo $response | sed -r 's/.*<error_msg>(.*)<\/error_msg>.*/\1/' >&2
	exit 3
fi

# parse the response and output our stuff
url=$(echo $response | sed -r 's/.*<original_image>(.*)<\/original_image>.*/\1/')
deleteurl=$(echo $response | sed -r 's/.*<delete_page>(.*)<\/delete_page>.*/\1/')
echo $url
echo "Delete page: $deleteurl" >&2

# put the URL on the clipboard if we have xsel or xclip
if [ $DISPLAY ]; then
	{ which xsel >/dev/null 2>/dev/null && echo -n $url | xsel; } \
		|| { which xclip >/dev/null 2>/dev/null && echo -n $url | xclip; } \
		|| echo "Haven't copied to the clipboard: no xsel or xclip" >&2
else
	echo "Haven't copied to the clipboard: no \$DISPLAY" >&2
fi
