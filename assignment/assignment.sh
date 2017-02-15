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
}

# Verify a verification file
verify(){
	# Creates a new verification file
	create .verification
	
	# Gets the name of the old verification file.
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
		filetype=`echo $line | awk '{ print $3 }'`
		
		# The name of the file owner
		owner=`echo $line | awk '{ print $5 }'`
		
		# The group of the file
		group=`echo $line | awk '{ print $6 }'`
		
		# The date the file was last modified
		date=`echo $line | awk '{ print $7, $8, $9 }'`
		
		# The md5 checksum of the file
		hash=`echo $line | awk '{ print $10 }'`
		
		search=`grep -w $filename .verification`
		
		#echo $search
		
		# If search is not empty 
		if [ "$search" != "" ]
		# Then read all of the file attributes and compare them
		then
				# The name of the file
				filename2=`echo $search | awk '{ print $2 }'`
				if [ "$filename" != "$filename2" ]
				then
					echo ""
				fi
				# The file path where the file is located
				filepath2=`echo $search | awk '{ print $1 }'`
				if [ "$filepath" != "$filepath2" ]
				then
					echo "$filename Filepath changed"
				fi
				# The access permissions for user groups
				access2=`echo $search | awk '{ print $4 }'`
				if [ "$access" != "$access2" ]
				then
					echo "$filename Access Permissions changed"
				fi
				# Extract the type of file symbol from the access permissions
				filetype2=`echo $search | awk '{ print $3 }'`
				if [ "$filetype" != "$filetype2" ]
				then
					echo "$filename File type has changed"
				fi
				# The name of the file owner
				owner2=`echo $search | awk '{ print $5 }'`
				if [ "$owner" != "$owner2" ]
				then
					echo "$filename owner changed"
				fi
				# The group of the file
				group2=`echo $search | awk '{ print $6 }'`
				if [ "$group" != "$group" ]
				then
					echo "$filename group has changed"
				fi
				# The date the file was last modified
				date2=`echo $search | awk '{ print $7, $8, $9 }'`
				if [ "$date" != "$date2" ]
				then
					echo "$filename has been modified"
				fi
				# The md5 checksum of the file
				hash2=`echo $search | awk '{ print $10 }'`
				if [ "$hash" != "$hash" ]
				then
					echo "$filename contents have changed"
				fi
		# If search is empty then say it wasnt found
		else
			sed -e "s/$search//g" -i .verification
			#sed 's@'"$search"'@@'
			#echo "memes"
			echo "fuck"
		fi
		# echo "$filepath $filename $filetype $access $owner $group $date $hash" 
		
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
				# Creates a file that contains the name of the name of the verification file
				touch .snapshotname
				echo "$1" >> .snapshotname
				
				# Calls the create function with the users viven name
				create $1
				echo "File Created."
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
