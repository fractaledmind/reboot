#!/usr/bin/env bash
#
#
#
set -e

source "$lib/app_path/index.sh"
source "$lib/symlink/index.sh"
# path to PlistBuddy
buddy='/usr/libexec/PlistBuddy'
# glob path to custom file type icons
file_icons="$lib/custom_icons/files/*"


main() {

  # Iterate over only the .png files
  for icon in $file_icons
  do
    # get name of file
    icon_file=$(basename "$icon")
    icon_name="${icon_file%.*}"
    # split app name from file name in file
    data_array=(${icon_name//_/ })
    app_name=${data_array[0]}
    file_name=${data_array[1]}
    # get key paths for that app
    app=$(app_path "$app_name")
    app_plist="$app""/Contents/Info.plist"
    app_rsc="$app""/Contents/Resources"

    # Get list of icons set by app (as newline delimited string)
    icons=$($buddy -c "print CFBundleDocumentTypes" "$app_plist" | grep "CFBundleTypeIconFile")
    # Remove the key from newline delimited string
    clean=${icons//'CFBundleTypeIconFile = '/''}
    # Split string into array
    array=(${clean//$'\n'/ })
    for i in "${!array[@]}"
    do
      if [ "${array[i]}" == "$file_name" ]; then
        icon_path="$app_rsc"'/'"${array[i]}"'.icns'
        symlink "$icon" "$icon_path"
      fi
    done
  done
}

#if [[ -e "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister" ]]; then
#  echo "found"
#fi

main "$@"
exit 0
