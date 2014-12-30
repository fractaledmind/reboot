#!/usr/bin/env bash
version="0.1.0"

# dots(1) main
main() {

  # paths
  export dirname=$(dirname $(realpath $0))
  export lib="$dirname/lib"
  export os="$dirname/os"

  # parse options
  while [[ "$1" =~ ^- ]]; do
    case $1 in
      -v | --version )
        echo $version
        exit
        ;;
      -h | --help )
        usage
        exit
        ;;
    esac
    shift
  done

  # run command
  case $1 in
    reload )
      reload
      exit
      ;;
    boot )
      boot
      exit
      ;;
    setup )
      setup
      exit
      ;;
    icons )
      customize_icons $2
      exit
      ;;
    update )
      update
      exit
      ;;
    *)
      usage
      exit
      ;;
  esac
}

reload() {
  # symlink new profile
  source "$lib/symlink/index.sh"
  symlink "$os/osx/boot/profile.sh" "$HOME/.bash_profile"
  source "$HOME/.bash_profile"
}
# usage info
usage() {
  cat <<EOF

  Usage: dots [options] [command] [args ...]

  Options:

    -v, --version           Get the version
    -h, --help              This message

  Commands:

    reload                Reload the dotfiles
    boot                  Bootstrap the given operating system
    setup                 Finish setup process after Dropbox sync
    update <dots>         Update the os or dots
    icons <app>           Set custom icon for app

EOF
}

# Bootstrap the OS
boot() {
  if [[ -e "$os/osx/boot/index.sh" ]]; then
    sh "$os/osx/boot/index.sh"
  else
    echo "boot: could not find osx boot script!"
    exit 1
  fi
}

setup() {
  if [[ -e "$os/osx/setup/index.sh" ]]; then
    sh "$os/osx/setup/index.sh"
  else
    echo "setup: could not find osx setup script!"
    exit 1
  fi
}

customize_icons() {
  if [[ -e "$os/osx/icons/index.sh" ]]; then
    sh "$os/osx/icons/index.sh" $1
  else
    echo "icons: could not find osx icons script!"
    exit 1
  fi
}

# update either dots or OS
update() {
  if [[ -e "$os/osx/update/index.sh" ]]; then
    sh "$os/osx/update/index.sh"
  else
    updatedots
  fi
}

# update dots(1) via git clone
updatedots() {
  echo "updating dots..."
  mkdir -p /tmp/dots \
    && cd /tmp/dots \
    && curl -L# https://github.com/smargh/dots/archive/master.tar.gz | tar zx --strip 1 \
    && ./install.sh \
    && echo "updated dots to $(dots --version)."
  exit
}

# "readlink -f" shim for mac os x
realpath() {
  target=$1
  cd `dirname $target`
  target=`basename $target`

  # Iterate down a (possible) chain of symlinks
  while [ -L "$target" ]
  do
      target=`readlink $target`
      cd `dirname $target`
      target=`basename $target`
  done

  dir=`pwd -P`
  echo $dir/$target
}

# Call main
main "$@"
