#!/usr/bin/env bash
#
# Binary installer
#
set -e

# Binaries
binaries=(
  autoenv
  rename
  ffmpeg
  python
  python3
  pandoc
  trash
  tree
  wget
  ack
  git
  hub
)

# Main program
main() {
  # Ensure homebrew is installed
  homebrew

  # Update homebrew
  brew update && brew doctor

  # Install tesseract ocr engine and all dependencies
  echo ":dots: installing tesseract and dependencies..."
  tesseract

  # Install common, core GNU tools
  echo ":dots: installing GNU tools..."
  gnu_tools

  # Install the binaries
  echo ":dots: installing binaries..."
  brew install ${binaries[@]}

  # Add osx specific command line tools
  echo ":dots: installing command line tools..."
  command_line_tools

  # Remove outdated versions from the cellar
  brew cleanup
}

homebrew() {
  # Check for Homebrew
  if test ! $(which brew); then
    echo ":dots: installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

tesseract() {
  #!/usr/bin/env bash
  # courtesy of : <https://ryanfb.github.io/etc/2014/11/13/command_line_ocr_on_mac_os_x.html>

  # Install leptonica with TIFF support (and every other format, just in case)
  brew install --with-libtiff --with-openjpeg --with-giflib leptonica

  # Install Ghostscript
  brew install gs

  # Install ImageMagick with TIFF and Ghostscript support
  brew install --with-libtiff --with-ghostscript imagemagick

  # Install Tesseract devel with all languages
  brew install --devel --all-languages tesseract
}

gnu_tools() {
  # Install GNU core utilities (those that come with OS X are outdated)
  brew install coreutils

  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
  brew install findutils

  # Install Bash 4
  brew install bash

  # Install more recent versions of some OS X tools
  brew tap homebrew/dupes
  brew install homebrew/dupes/grep
}

command_line_tools() {
  # Install Sublime Text CLI
  if test ! $(which subl); then
    ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
  fi

  # Install spot
  if test ! $(which spot); then
    curl -L https://raw.github.com/guille/spot/master/spot.sh -o /usr/local/bin/spot && chmod +x /usr/local/bin/spot
  fi
}

main "$@"
exit 0
