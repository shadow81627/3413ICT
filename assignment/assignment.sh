#!/bin/sh

# Create a verification file
create(){
	touch $1


	ls -l | while read line
	do
		echo "$line"  > $1
		echo $line | awk '{ md5sum "${!#}" }'
	done
	echo "File Created."
}

# Verify a verification file
verify(){
	echo ""
}


# Choose which action to preform based on user input
if [ "$1" != "" ]; then
	case $1 in
		# Command to create a new file
		-c | --create)
			# Shift the command line arguments.
			shift
			# Check to see if there is a file name.
			if [ "$1" != "" ] 
			then
			# If there is a file name then use it as an argument for create.
				create $1
			else
			# If there is no file name given then use a default name.
				create "verification"
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
			;;
	esac
fi
