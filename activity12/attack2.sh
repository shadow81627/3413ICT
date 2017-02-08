#!/bin/sh

ln -sf /home/seed/myfile /tmp/std1

# Make a symbolic link between passwd file and std file any change made in one file will reflect in the other.
ln -sf /etc/shadow /tmp/std1




