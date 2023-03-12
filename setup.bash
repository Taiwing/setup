#!/usr/bin/env bash

################################# utils ########################################

function usage {
	cat << EOF
Usage:
    ./setup.bash
    ./setup.bash -u

Options:
    -h, --help
        Print this.

    -v, --verbose
	Show each line of this script before execution.

    -i, --install
	Install packet managers and dependencies. Also creates the configuration
	files. This is the default behavior.

    -u, --uninstall
        Uninstall packet managers, every program installed with them, and remove
	the configuration files created by this script (make sure to save them
	if any meaningful local modification has been made).
EOF
}

############################### Handle options #################################

SYSTEM="$(uname)"
INSTALL="yes"

while [ "$1" != "" ]; do
	case $1 in
	-h | --help )
		usage
		exit 0
		;;
	-v | --verbose )
		set -o xtrace
		;;
	-i | --install )
		INSTALL="yes"
		;;
	-u | --uninstall )
		INSTALL=""
		;;
	* )
		usage
		exit 1
	esac
	shift
done

########################## Install Configuration files #########################

if [ ! -z $INSTALL ]; then
	mkdir -p $HOME/.config/alacritty
	cp ./config/alacritty.yml $HOME/.config/alacritty
	cp ./config/bash_aliases $HOME/.bash_aliases
	cp ./config/profile $HOME/.profile
	cp ./config/tmux.conf $HOME/.tmux.conf
	cp ./config/vimrc $HOME/.vimrc
fi


################################ Install nix ###################################

if [ ! -z $INSTALL ]; then
	sh <(curl -L https://nixos.org/nix/install) --daemon
fi

######################### Install dependencies #################################

NIX_DEPS="alacritty bat ripgrep thefuck vim"

if [ ! -z $INSTALL ]; then
	pacman -Syu tmux
	for DEP of $NIX_DEPS; do
		nix-env --install $DEP
	done
fi

########################### Uninstall nix dependencies #########################

if [ -z $INSTALL ]; then
	for DEP of $NIX_DEPS; do
		nix-env --uninstall $DEP
	done
	nix-collect-garbage
fi

######################## Uninstall Configuration files #########################

if [ -z $INSTALL ]; then
	rm $HOME/.config/alacritty
	rmdir $HOME/.config/alacritty &> /dev/null
	rmdir $HOME/.config/ &> /dev/null
	rm $HOME/.bash_aliases
	rm $HOME/.profile
	rm $HOME/.tmux.conf
	rm $HOME/.vimrc
fi
