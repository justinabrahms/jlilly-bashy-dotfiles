#!/usr/bin/tcsh
# Show or hide desktop icons in gnome
# via http://www.ivy.fr/blog/index.php/2008/05/08/85-from-macos-to-ubuntu-show-hide-desktop-icons-on-gnome

if ( `gconftool --get /apps/nautilus/preferences/show_desktop` == "true" ) then
       gconftool --set /apps/nautilus/preferences/show_desktop \
                 --type boolean false
else
       gconftool --set /apps/nautilus/preferences/show_desktop \
                 --type boolean true
endif
# EOF
