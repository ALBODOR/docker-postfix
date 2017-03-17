#!/bin/bash
if [[ $1 ]]; then
	docker build -t postfix:$1 .
else 
	echo "Usage: ./build.sh <build-version>"
fi
