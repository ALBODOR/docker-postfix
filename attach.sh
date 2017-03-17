#!/bin/bash
command="docker exec -it "
if [[ $1 ]]; then
	command="$command $1 bash"
else
	echo "No container name was given ... using postfix as default!"
	command="$command postfix bash"
fi

# Uncomment next line for debugging
#echo $command
$command
