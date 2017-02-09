#!/bin/sh

# find . -type f -exec sh -c 'printf "%s %s \n" "$(ls -l $1)" "$(md5sum $1)"' '' '{}' '{}' \;
# Create a verification file
create(){
	
	data=`echo ls -l`
	touch $1
	printf "" > $1
	$data | while read line
	do		
		# The name of the file
		filename=`echo $line | awk '{ print $9 }'`
		# The file path where the file is located
		#filepath=`echo readlink -f $filename`
		# The access permissions for user groups
		access=`echo $line | awk '{ print $1 }'`
		# The type of file
		filetype=`echo $access | awk '{print substr($0,0,2)}'`
		case $filetype in
			-)
				filetype="regular file"
				;;
			d)
				filetype="directory"
				;;
			l)
				filetype="symlink"
				;;
			*)
				filetype="unknown"
				;;
		esac
		# The
		owner=`echo $line | awk '{ print $3 }'`
		group=`echo $line | awk '{ print $4 }'`
		date=`echo $line | awk '{ print $6, $7, $8 }'`
		hash=`md5sum ${1} | awk '{ print $1 }'`
		
		echo "$filepath $filename $filetype $access $owner $group $date $hash" >> $1
		
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
