#!/bin/bash
set -e
if [[ $1  ]]; then
	docker run -d -p 25:25 --name postfix postfix:$1
else
	echo "Usage : ./run.sh <image-version>"
fi
