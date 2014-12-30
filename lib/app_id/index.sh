#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
LIB=$(dirname "$DIR")

source "$LIB/app_path/index.sh"

function app_id {
  # via <http://brettterpstra.com/2012/07/31/overthinking-it-fast-bundle-id-retrieval-for-mac-apps/>
  local shortname location

  # remove ".app" from the end if it exists due to autocomplete
  shortname=$(echo "${@%%.app}")
  location=$(app_path "$shortname")

  if [[ -z $location || $location = "" ]]; then
    # No results? Die.
    echo "$1 not found, I quit"
    exit 1
  else
    # Otherwise, find the bundleid using spotlight metadata
    bundleid=$(mdls -name kMDItemCFBundleIdentifier -r "$location")
    # return the result or an error message
    if [[ -z $bundleid || $bundleid = "" ]]; then
      echo "Error getting bundle ID for \"$@\""
    else
      echo "$bundleid"
    fi
  fi
}
