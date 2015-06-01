#!/bin/bash

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

if [ "$1" == "true" ]
then
	docker rmi $(docker images -q)
fi