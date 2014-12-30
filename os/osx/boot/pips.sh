#!/usr/bin/env bash
#
# Installer for global Python modules
#
set -e

pips=(
  mackup
  autoenv
  setuptools
  virtualenv
  cookiecutter
  virtualenvwrapper
)

main() {
  echo ":dots: installing global Python modules..."
  gpip install ${pips[@]}
}

main "$@"
exit 0
