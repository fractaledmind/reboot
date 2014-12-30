#!/usr/bin/env bash
#
#
# x=~/Library/Preferences/com.apple.LaunchServices.plist; plutil -convert xml1 $x; open -a "Sublime Text" $x
set -e

ls_plist="$HOME/Library/Preferences/com.apple.LaunchServices.plist"
buddy='/usr/libexec/PlistBuddy'

source "$lib/app_id/index.sh"

main() {

  declare -A utis=(
    ["public.plain-text"]=$(app_id "sublime")
    ["com.adobe.pdf"]=$(app_id "skim")
    ["public.movie"]=$(app_id "vlc")
    ["public.script"]=$(app_id "sublime")
  )

  # `LSHandlers` array already exists
  if $(plist_element_exists "LSHandlers"); then
    # Iterate over handlers
    declare -i I=0
    while [ true ] ; do
      if $(plist_element_exists "LSHandlers:$I"); then
        # get handler content type
        key=$($buddy -c "print "LSHandlers:$I:LSHandlerContentType"" "$ls_plist")
        if [[ "${utis[public.movie]}" != '' ]]; then
          # set specified app id for that content type
          $buddy -c "set "LSHandlers:$I:LSHandlerRoleAll" "${utis[$key]}"" "$ls_plist"
        else
          echo "not"
        fi
        # increment counter
        I=$I+1
      else
        exit
      fi
    done
  else
    for k in "${!utis[@]}"
    do
      defaults write com.apple.LaunchServices LSHandlers -array-add "{ LSHandlerContentType = "$k"; LSHandlerRoleAll = "${utis[$k]}"; }"
    done
  fi
}

plist_element_exists() {
  ret=$($buddy -c "print "$1"" "$ls_plist" 2>&1)

  if [[ "$ret" == *'Does Not Exist'* ]] ; then
    return 1
  else
    return 0
  fi
}


main "$@"
