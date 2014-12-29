#!/usr/bin/env bash
#
# Post-processing
#
set -e

main() {

  # use mackup to restore configs
  mac_backup

  # link with alfred
  alfred

  # remove outdated versions from the cellar
  cleanup
}

mac_backup() {
  if test ! $(which mackup); then
    echo ":dots: installing mackup..."
    brew install mackup
  fi

  # restore previously backed up configuration files
  mackup restore
}

alfred() {
  echo ":dots: linking Alfred..."
  brew cask alfred link
}

cleanup() {
  echo ":dots: cleaning up..."
  brew cleanup && brew cask cleanup
}


main "$@"
exit 0
