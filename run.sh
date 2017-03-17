#!/bin/bash
set -e
command="docker run -d -p 25:25 "

# Container name parameter
if [[ $2 ]]; then
	command="$command --name $2"
fi

# Image version parameter
if [[ $1  ]]; then
	command="$command postfix:$1"
else
	echo "Usage : ./run.sh <image-version> [<container-name>] [<domain-name>]"
	exit 0
fi

# Domain name parameter
if [[ $3 ]]; then
	command="$command $3"
fi

# Uncomment next line for debugging
#echo $command
$command
