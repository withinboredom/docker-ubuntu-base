#!/bin/bash

doBuild=$1

if [ "$doBuild" == "true" ]
then
	./build-all.sh
else
	echo "This is gonna be a minute"
fi

function stop() {
	docker stop node
	docker stop blue-volume-1
	docker stop blue-volume-2
	docker stop blue-volume-3
	docker stop sdiscover
	docker stop consul
	docker stop mysql-seed
	docker stop mysql-slave-seed-1
	docker stop rethink
}

function kill() {
	docker rm node
	docker rm blue-volume-1
	docker rm blue-volume-2
	docker rm blue-volume-3
	docker rm sdiscover
	docker rm consul
	docker rm mysql-seed
	docker rm mysql-slave-seed-1
	docker rm rethink
}

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

#stop
#kill

./clean.sh

cwd=$(pwd)
doPause="false"
machineIP=$(docker-machine ip)

#startContainer node withinboredom/node "-v /var/run/docker.sock:/var/run/docker.sock"

startContainer consul withinboredom/consul-ui
getIp consul
MASTER=$dockerip

startContainer sdiscover withinboredom/blue-volume-discover
doPause="true"
startContainer blue-volume-1 withinboredom/blue-volume
#startContainer blue-volume-2 withinboredom/blue-volume
#startContainer blue-volume-3 withinboredom/blue-volume
doPause="false"
startContainer mysql-seed withinboredom/mysql "-e MYSQL_USER=admin -e MYSQL_PASS=123 -e REPLICATION_MASTER=true"
startContainer mysql-slave-seed-1 withinboredom/mysql "-e MYSQL_USER=admin -e MYSQL_PASS=123 -e REPLICATION_SLAVE=true -e MYSQL_PORT_3306_TCP_ADDR=mysql-master.service.consul -e MYSQL_PORT_3306_TCP_PORT=3306"
#startContainer rethink withinboredom/rethinkdb
#startContainer kube withinboredom/basic-node "-v /var/run/docker.sock:/var/run/docker.sock -e APIP=$machineIP"
#getIp kube
#MASTER=$dockerip
startContainer registrator gliderlabs/registrator:latest "-v /var/run/docker.sock:/tmp/docker.sock -h $HOSTNAME" "consul://$MASTER:8500 -resync 1"