#!/bin/sh

# Read in two numbers seperated by a space.
echo "Enter two numbers: "
read numbers

# Read in an operation to be preformed on the given numbers.
echo "Enter the operation: "
read operation

# Add function preforms the add operation on two given numbers.
Add (){
	echo expr $1 + $2
}

# Subtract function preforms the stubtraction operation on two given numbers.
Subtract (){
	echo expr $1 - $2
}

# Multiply function preforms the multiplication operation on two given numbers.
Multiply (){
	echo expr $1 * $2
}

# Divide function preforms the division operation on two given numbers.
Divide (){
	
}