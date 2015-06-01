#!/bin/bash

json=$1
declare -A exports

function getDC() {
	current_dc="local"
}

function setDC() {
	dc=$(cat $json | jq --raw-output '.dc')

	if [ "$dc" == "*" ]
	then
		dc=$current_dc
	fi

	echo "Sending service to $dc dc"
}

function getNodeGroups() {
	groups=( "backend" "frontend" )
}

function setNode() {
	node="n123"
	echo "Deploying service to backend.n123"
}

function configureService() {
	serviceCount=$(cat $json | jq '.service.machines | length')
	for i in `seq 1 $serviceCount`
	do
		service=$(cat $json | jq -c ".service.machines[$i - 1]")
		echo "Starting service on $node"
		echo $service | jq "."
		image=$(echo $service | jq -c -R '.image')
		vars=($(echo $service | jq -c -R '.vars'))
		configureExports

	done
}

function configureExports() {
	exports["prod_db"]="3306"
}

getDC
setDC
getNodeGroups
setNode
configureService