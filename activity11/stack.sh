#!/bin/sh

i=1
while true 
do
	./stack_dbg
	i=$((i+1))
	echo "$i"
done
