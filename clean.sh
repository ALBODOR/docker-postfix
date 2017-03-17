#!/bin/bash
set -e

# Stopping and removing a running container
command1="docker container stop "
command2="docker container rm "
if [[ $1 ]]; then
	command1="$command1 $1"
	command2="$command2 $1"
else 
	echo "No container name was given ... using postfix as default!"
	command1="$command1 postfix"
	command2="$command2 postfix"	
fi
# Uncomment next two lines for debugging
#echo $command1
#echo $command2
$command1
$command2

# Optional: Deleting docker image as well
if [[ $2 ]]; then 
	docker rmi $2
fi
