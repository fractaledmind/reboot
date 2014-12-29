#!/usr/bin/env bash
#
# Main script for initialization
#
set -e

logo=$(cat "$dirname/logo")
echo "$logo"
echo ""
echo ""

# make functions available from lib modules
source "$lib/symlink/index.sh"
source "$lib/is-osx/index.sh"

# Only run if on a Mac
if [ 0 -eq `osx` ]; then
  exit 0
fi

# exit 1
# paths
osx="$os/osx"

# Run each program
#sh "$osx/defaults.sh"
#sh "$osx/binaries.sh"
#sh "$osx/apps.sh"
#sh "$osx/pips.sh"

# Symlink the profile
if [[ ! -e "$HOME/.bash_profile" ]]; then
  echo ":dots: symlinking \`$osx/boot/profile.sh\` => \`$HOME/.bash_profile\`..."
  symlink "$osx/boot/profile.sh" "$HOME/.bash_profile"
  source "$HOME/.bash_profile"
else
  echo ":dots: \`$HOME/.bash_profile\` already exists."
fi
