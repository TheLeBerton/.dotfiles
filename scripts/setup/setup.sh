#!/bin/bash


# This script checks for required dependencies.
# Then creates symbolic links for the dotfiles in the home directory.


SPINNER=$HOME/.dotfiles/scripts/utils/spinner.sh
DEPENDENCIES=$HOME/.dotfiles/scripts/setup/check_dependecies.sh
LINK=$HOME/.dotfiles/scripts/setup/link_dotfiles.sh


main() {
	$SPINNER $DEPENDENCIES
	$SPINNER $LINK
}

main
