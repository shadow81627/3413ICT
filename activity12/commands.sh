#!/bin/sh

# Turn off built in race condition protection
sudo sysctl -w kernel.yama.protected_sticky_symlinks=0

# Compile the vulp file
gcc vulp.c -o vulp

# Allows the users to exec a program with the permissions of its owner.
sudo chown root vulp

# Give the file super user privilage
sudo chmod u+s vulp

# List the vulp attributes
ll vulp
