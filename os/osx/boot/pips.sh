#!/usr/bin/env bash
#
# Installer for global Python modules
#
set -e

pips=(
	mackup
	setuptools
  virtualenv
	virtualenvwrapper
)

main() {
	echo ":dots: installing global Python modules..."
  gpip install ${pips[@]}
}

main "$@"
exit 0
