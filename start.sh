#!/bin/bash
# Help/usage text
help() {
	echo "Usage: ${0} -l <path> -p <path> -i -q [name]"
	echo "  -i		optional: interactive mode (not daemonized)"
	echo "  -q		optional: disable daemon console logging"
	echo "  -l		optional: log file path"
	echo "  -p		optional: machine path"
	echo "  name	  	machine name"
	exit
}


# "Declare" variable
interactive=
logfile=
quietdaemon=
cmd="sudo lxc-start"

# Parse arguments
while getopts "l:i" OPTION; do
	case $OPTION in
		i)
			interactive=1;;
		l)
			logfile=$OPTARG;;
		q)
			quietdaemon=1;;
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


# Check for path
if [ -z $path ]; then
	path=`pwd`
fi


# Make sure $path exists
if [ ! -d $path ]; then
	echo "Error: Bad path"
	help
fi


# Make sure log file path exists
if [ ! -z $logfile ]; then
	if [ ! -d $logfile ]; then
		echo "Error: Bad log file path"
		help
	else
		cmd="${cmd} -o ${logfile}"
	fi
fi


# Check for interactive mode
if [ -z $interactive ]; then
	cmd="${cmd} -d"

	# Disable console logging
	if [ -z $quietmode ]; then
		cmd="${cmd} -c ${path}/${name}/console.log"
	fi
fi


# Add the name
cmd="${cmd} -n ${name}"
