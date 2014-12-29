#!/usr/bin/env bash
#
# Custom Icon installer
#
# written with help of:
# <http://blog.observationpoint.org/post/35715124002/setting-custom-icon-on-folders-in-mac-os-x-from>
# <http://apple.stackexchange.com/questions/6901/how-can-i-change-a-file-or-folder-icon-using-the-terminal>
# <http://superuser.com/questions/298785/icon-file-on-os-x-desktop>
set -e

icons_dir="$lib/custom_icons"
app_icons="$icons_dir/apps/*"

main() {

  # Iterate over only the .png files
  for icon in $app_icons
  do
    icon_file=$(basename "$icon")
    icon_name="${icon_file%.*}"

    # Only run on passed app name, or run on all
    if [ "$icon_name" == "$1" ] || [ "$1" == "all" ]; then

      # Get path to homebrew-cask installed application
      app_path=$(brew cask list "$icon_name" | grep '.app/Contents/ (' | sed -n -e 's/^\(^.*.app\).*$/\1/p')

      # Take a png image and make it its own icon
      sips -i "$icon"

      # Extract this icon to its own resource file
      derez -only icns "$icon" > "$dirname/tmpicns.rsrc"

      # Append this resource to the app you want to icon-ize
      rez -append "$dirname/tmpicns.rsrc" -o "$app_path"/$'Icon\r'

      # Use the resource to set the icon.
      setfile -a C "$app_path"

      # Hide the Icon\r file from Finder.
      chflags hidden "$app_path"/$'Icon\r'

      # clean up.
      rm "$dirname/tmpicns.rsrc"
    fi
  done
}

main "$@"
exit 0
