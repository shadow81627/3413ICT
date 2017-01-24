#!/bin/sh

# Add function preforms the add operation on two given numbers.
add (){
	echo `expr $1 + $2`
}

# Subtract function preforms the stubtraction operation on two given numbers.
subtract (){
	echo `expr $1 - $2`
}

# Multiply function preforms the multiplication operation on two given numbers.
multiply (){
	echo `expr $1 * $2`
}

# Divide function preforms the division operation on two given numbers.
divide (){
	echo `expr $1 + $2`
}


# Read in two numbers seperated by a space.
echo "Enter two numbers: "
read number1 
read number2

# Read in an operation to be preformed on the given numbers.
echo "Enter the operation: "
read operation

# Case stament to choose which operation to preform.
case $operation in
	add)
		add $number1 $number2
		;;
	sub)
		subtract $number1 $number2
		;;
	mul)
		multiply $number1 $number2
		;;
	div)
		divide $number1 $number2
		;;
esac
	

