#!/bin/bash

push=$1
PUSH=()

function push() {
	base=$1
	if [ "$push" == "true" ]
	then
		PUSH+=("$base/push.sh")
	fi
}

function build() {
	base=$1
	$base/build.sh
	wait
}

function bp() {
	base=$1
	build $base
	push $base
}

function doPush() {
	for p in "${PUSH[@]}"
	do
		$p
	done
}

bp ubuntu-base
bp consul
bp consul-ui
bp consul-agent
bp nodejs
bp rethinkdb
bp blue-volume
bp blue-volume-discover
bp mysql
bp node
bp nginx

doPush

#ubuntu-base/build.sh
#ubuntu-base/push.sh &
#consul/build.sh
#consul/push.sh &
#node/build.sh
#node/push.sh &
#consul-ui/build.sh
#consul-ui/push.sh &
#consul-agent/build.sh
#consul-agent/push.sh &
#rethinkdb/build.sh
#rethinkdb/push.sh &
#blue-volume/build.sh
#blue-volume/push.sh &
#blue-volume-discover/build.sh
#blue-volume-discover/push.sh &
#mysql/build.sh
#mysql/push.sh &

echo "Waiting for pushes to complete..."
wait
echo "Push complete!!"