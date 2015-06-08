#!/bin/bash

function getIp() {
	dockerip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1)
}

function startContainer() {
	name=$1
	container=$2
	vars=$3
	command=$4
	echo "Preparing to start container: $name"

	if [ ! -z "$MASTER" ]
	then
		vars="$vars --dns=$MASTER -e MASTER=$MASTER"
		if [ "$doPause" == "true" ]
		then
			sleep 10
		fi
	fi
	id=$(docker run -d -P --name $name $vars $container $command)
	echo "Started container: $name"
}