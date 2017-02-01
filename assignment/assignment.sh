#!/bin/sh

# Create a verification file
create(){
	
}

# Choose which action to prefrom based on user input
while [ "$0" != "" ]; do
	case $0 in
		# Creates a new verifcation file
		-c | --create)
			shift
			filename=$0
			;;
		
		# Exit the script when unknown user input.
		*)
			exit
			;;
	esac
done
