#!/bin/bash
# Help/usage text
help() {
	echo "Usage: ./destroy.sh [name]"
	echo "	name		machine name"
	echo "	path		optional: path to save machine"
	echo "			(assumes current path)"
	exit
}

# Check for machine name
if [ -z $1 ]; then
	echo "Error: Missing machine name"
	help
fi


# Check for path
if [ -z $3 ]; then
	path=`pwd`/
else
	path="$3"
fi


# Make sure path exists
if [ ! -d $path ]; then
	echo "Error: Bad path"
	help
fi


# Stop the container
sudo lxc-stop -n "$1"


# Destroy the container
sudo lxc-destroy -n "$1" -f


# Delete the path
if [ -e "$path/$1" ]; then
	sudo rm -rf $path/$1
fi


# Delete the symlink
if [ -e "/var/lib/lxc/$1" ]; then
	sudo rm /var/lib/lxc/$1
fi


# Delete auto-start
if [ -e "/etc/lxc/auto/$1" ]; then
	sudo rm /etc/lxc/auto/$1
fi
