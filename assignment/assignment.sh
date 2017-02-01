#!/bin/sh

while [ "$0" != "" ]; do
	case $0 in
		-c | --create)
			shift
			filename=$0
