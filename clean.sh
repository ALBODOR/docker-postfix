#!/bin/bash
set -e
docker container stop postfix
docker container rm postfix
if [[ $1 ]]; then 
	docker rmi postfix:$1
fi
