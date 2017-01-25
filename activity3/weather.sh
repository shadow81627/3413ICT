#!/bin/sh

# Reads the input from a user and a file and compares the user input to the file input, 
# if the input matches then the line in the file will be displayed.

# Read in a weather condition.
echo "Enter weather condition (sunny, rainy, windy, foggy):  "
read input

#Read the weather records file
cat weather_records.txt | while read line
do
	#get the third word in the weather record and store it int he varible weather.
	weather=`echo $line | awk '{print $3 }'`
	
	#if the input matches the weather record then print out the weatehr record.
	if [ "$input" = "$weather" ]
	then
		echo "$line."
	fi
done

echo "Have another try."
