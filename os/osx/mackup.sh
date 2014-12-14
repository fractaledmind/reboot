if test ! $(which mackup); then
  echo "Installing mackup..."
  brew install mackup
fi

# restore previously backed up configuration files
mackup restore
