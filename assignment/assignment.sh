#!/bin/sh

# find . -type f -exec sh -c 'printf "%s %s \n" "$(ls -l $1)" "$(md5sum $1)"' '' '{}' '{}' \;
# Create a verification file
create(){
	
	data=`echo ls -ld **`
	touch $1
	printf "" > $1
	$data | while read line
	do		
		# The name of the file
		filename=`echo $line | awk '{ print $9 }'`
		
		# The file path where the file is located
		filepath=`readlink -f $filename`
		
		# The access permissions for user groups
		access=`echo $line | awk '{ print $1 }'`
		
		# Extract the type of file symbol from the access permissions
		filetype=`echo $access | awk '{print substr($0,0,1)}'`
		
		# Change the file type to be a string rather than symbol
		case $filetype in
			-)
				filetype="regular"
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
		
		# The name of the file owner
		owner=`echo $line | awk '{ print $3 }'`
		
		# The group of the file
		group=`echo $line | awk '{ print $4 }'`
		
		# The date the file was last modified
		date=`echo $line | awk '{ print $6, $7, $8 }'`
		
		# The md5 checksum of the file
		hash=`md5sum $1 | awk '{ print $1 }'`
		
		echo "$filepath $filename $filetype $access $owner $group $date $hash" >> $1
		
	done
	echo "File Created."
}

# Verify a verification file
verify(){
	#grep -w "boo" file
	verification=`cat .snapshotname`
	
	cat $verification | while read line
	do
		# The name of the file
		filename=`echo $line | awk '{ print $2 }'`
		
		# The file path where the file is located
		filepath=`echo $line | awk '{ print $1 }'`
		
		# The access permissions for user groups
		access=`echo $line | awk '{ print $4 }'`
		
		# Extract the type of file symbol from the access permissions
		filetype=`echo $line | awk '{print $3}'`
		
		# The name of the file owner
		owner=`echo $line | awk '{ print $5 }'`
		
		# The group of the file
		group=`echo $line | awk '{ print $6 }'`
		
		# The date the file was last modified
		date=`echo $line | awk '{ print $7, $8, $9 }'`
		
		# The md5 checksum of the file
		hash=`echo $line | awk '{ print $10 }'`
		
		echo "$filepath $filename $filetype $access $owner $group $date $hash" 
		
		#cat verification2 | grep -w 'Model'
	done
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
				touch .snapshotname
				echo "$1" >> .snapshotname
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
