#!/usr/bin/env bash
#
# Application installer (via brew-cask)
#
set -e

# Apps
apps=(
  alfred
  appcleaner
  caffeine
  copy
  daisydisk
  dash
  dropbox
  evernote
  flux
  google-chrome
  hazel
  iterm2
  mactex
  mailbox
  marked
  nvalt
  omnifocus
  1password
  qlmarkdown
  qlstephen
  quicklook-json
  shiori
  skim
  slack
  spectacle
  sublime-text3
  textexpander
  tower
  transmission
  transmit
  vlc
  zotero
)

# fonts
fonts=(
  font-inconsolata
  font-clear-sans
  font-roboto
)

# Specify the location of the apps
appdir="/Applications"

main() {

  # Ensure homebrew is installed
  homebrew

  # use cask to install apps
  cask_apps

  cask_fonts

}

homebrew() {
  if test ! $(which brew); then
    echo ":dots: installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

cask_apps() {
  if test ! $(brew cask --verion); then
    # Install homebrew-cask
    echo ":dots: installing cask..."
    brew install caskroom/cask/brew-cask

    # Tap alternative versions
    brew tap caskroom/versions
  fi

  # install apps
  echo ":dots: installing apps..."
  brew cask install --appdir=$appdir ${apps[@]}
}

cask_fonts() {
  # Tap the fonts
  brew tap caskroom/fonts

  # install fonts
  echo ":dots: installing fonts..."
  brew cask install ${fonts[@]}
}


main "$@"
exit 0
