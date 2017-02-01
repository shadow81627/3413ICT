#!/bin/sh

# Create a verification file
create(){
	touch $1
	echo "$1"


	ls -l
	echo "File Created"
}

# Verify a verification file
verify(){
	echo ""
}

# Choose which action to prefrom based on user input
while [ "$1" != "" ]; do
	case $1 in
		# Command to create a new file
		-c | --create)
			shift
			if [ "$1" != "" ] 
			then
				create $1
			else
				echo "pls enter file"
			fi
			;;
		# Command for file validation
		-v | --verify)
			shift
			verify $1
			;;
		
		# Exit the script when unknown user input.
		*)
			echo "Unknown input."
			exit
			;;
	esac
done
