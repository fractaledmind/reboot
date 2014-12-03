#
# Binary installer
#

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew
brew update && brew upgrade brew-cask

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Install other useful binaries
binaries=(
  graphicsmagick
  webkit2png
  phantomjs
  rename
  zopfli
  ffmpeg
  python
  mongo
  sshfs
  trash
  tree
  ack
  git
  hub
)

# Install the binaries
brew install ${binaries[@]}

# Add osx specific command line tools
if test ! $(which subl); then
  ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
fi

# Install spot
if test ! $(which spot); then
  curl -L https://raw.github.com/guille/spot/master/spot.sh -o /usr/local/bin/spot && chmod +x /usr/local/bin/spot
fi

# Remove outdated versions from the cellar
brew cleanup

tesseract() {
  #!/usr/bin/env bash
  # courtesy of : <https://ryanfb.github.io/etc/2014/11/13/command_line_ocr_on_mac_os_x.html>

  # Ensure `homebrew` is up-to-date and ready
  echo "Updating `homebrew`..."
  brew doctor

  # Install leptonica with TIFF support (and every other format, just in case)
  echo "Installing `leptonica`..."
  brew install --with-libtiff --with-openjpeg --with-giflib leptonica

  # Install Ghostscript
  echo "Installing `ghostscript`..."
  brew install gs

  # Install ImageMagick with TIFF and Ghostscript support
  echo "Installing `imagemagick`..."
  brew install --with-libtiff --with-ghostscript imagemagick

  # Install Tesseract devel with all languages
  echo "Installing `tesseract`..."
  brew install --devel --all-languages tesseract
}

exit 0
