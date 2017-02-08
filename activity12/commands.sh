#!/bin/sh

# Turn off built in race condition protection
sudo sysctl -w kernel.yama.protected_sticky_symlinks=0

# Compile the vulp file
gcc vulp.c -o vulp

