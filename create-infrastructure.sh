#!/bin/bash

./build-all.sh

function stop() {
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
	echo "Preparing to start container: $name"
	if [ ! -z "$MASTER" ]
	then
		vars="$vars --dns=$MASTER -e MASTER=$MASTER"
		sleep 10
	fi
	id=$(docker run -d -P --name $name $vars $container)
	echo "Started container: $name"
}

stop
kill

cwd=$(pwd)

startContainer consul withinboredom/consul-ui
getIp consul
MASTER=$dockerip

startContainer sdiscover withinboredom/blue-volume-discover
startContainer blue-volume-1 withinboredom/blue-volume
#startContainer blue-volume-2 withinboredom/blue-volume
#startContainer blue-volume-3 withinboredom/blue-volume
startContainer mysql-seed withinboredom/mysql "-e MYSQL_USER=admin -e MYSQL_PASS=123 -e REPLICATION_MASTER=true"
startContainer mysql-slave-seed-1 withinboredom/mysql "-e MYSQL_USER=admin -e MYSQL_PASS=123 -e REPLICATION_SLAVE=true -e MYSQL_PORT_3306_TCP_ADDR=mysql-master.service.consul -e MYSQL_PORT_3306_TCP_PORT=3306"
startContainer rethink withinboredom/rethinkdb