#!/usr/bin/env bash

function app_path {
  if [ -d "/Applications/$1.app" ]; then
    location="/Applications/$1.app"
  else # otherwise, start searching
    location=$(mdfind 'kMDItemKind == "Application"cd && kMDItemFSName == "*'"$1"'*"cd"')
  fi
  echo "$location"
}