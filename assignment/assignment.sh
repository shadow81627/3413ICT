#!/bin/sh

# find . -type f -exec sh -c 'printf "%s %s \n" "$(ls -l $1)" "$(md5sum $1)"' '' '{}' '{}' \;
# Create a verification file
create(){
	touch $1


	ls -l | while read line
	do
		#echo "$line"  > $1
		#echo $line | awk '/a/{$md5=md5sum $8} END {print md5}' >> $1
		
		# The name of the file
		filename=`echo $line | awk '{ print $9 }'`
		# The file path where the file is located
		#filepath=readlink -f $filename
		# The access permissions for user groups
		access=`echo $line | awk '{ print $1 }'`
		# The type of file
		filetype=`echo $access | awk '{print substr($0,0,1)}'`
		owner=`echo $line | awk '{ print $3 }'`
		group=`echo $line | awk '{ print $4 }'`
		date=`echo $line | awk '{ print $6, $7, $8 }'`
		
		echo "$filepath $filename $filetype $access $owner $group $date"
		
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
				echo "No file name given"
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
