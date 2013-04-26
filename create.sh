#!/bin/bash
# Where are teh templates?
lxc_templates="/usr/lib/lxc/templates"


# Help/usage text
help() {
	echo "Usage: ${0} -i <ip address> -p <path> -t <template> -r [name]"
	echo "  -i		optional: IP address/mask"
	echo "  -p		optional: path to save machine (default current path)"
	echo "  -t		optional: machine template (default \"default\")"
	echo "  -r		optional: rebuild template"
	echo "  name	  	machine name"
	exit
}


# "Declare" variable
ip=
path=
template="default"
cmd="sudo lxc-create"
rebuild=
autostart=


# Parse arguments
while getopts "p:i:t:a:r" OPTION; do
	case $OPTION in
		a)
			autostart=1;;
		i)
			ip=$OPTARG;;
		p)
			path=$OPTARG;;
		t)
			template=$OPTARG;;
		r)
			rebuild=1;;
		\?)
			echo "Invalid option: -$OPTARG";;
	esac
done


# Grab the machine name as the last argument
name=${@:$OPTIND:1}


# Check for machine name
if [ -z $name ]; then
	echo "Error: Missing machine name"
	help
fi


# Check for machine template
if [ ! -f "${lxc_templates}/lxc-${template}" ]; then
	echo "Error: Missing template name"
	help
fi


# Check for path
if [ -z $path ]; then
	path=`pwd`/
fi


# Make sure path exists
if [ ! -d $path ]; then
	echo "Error: Bad path"
	help
fi


# Make a config file
conf=$(mktemp /tmp/lxc.XXXXXXXX)

cat /etc/lxc/lxc.conf >> $conf


# If we have an IP address, create a config file
if [ ! -z $ip ]; then

	echo "lxc.network.ipv4 = ${ip}" >> $conf

	cmd="${cmd} -f ${conf}"
fi


# If we want to rebuild, add that to the command
if [ ! -z $rebuild ]; then
	cmd="${cmd} -- -F"
fi


# Build the rest of the lxc-create command
cmd="${cmd} -n ${name} -t ${template}"


# Create the container
$cmd


# Move the container
sudo mv /var/lib/lxc/$name $path/$name


# Symlink the container
sudo ln -s $path/$name /var/lib/lxc/$name


# Remove the config file
if [ -e $conf ]; then
	rm $conf
fi


# Add to autostart
if [ ! -z $autostart ]; then
	sudo ln -s $path/$name/config /etc/lxc/auto/$name
fi
