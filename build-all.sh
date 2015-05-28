#!/bin/bash

ubuntu-base/build.sh
ubuntu-base/push.sh &
consul/build.sh
consul/push.sh &
consul-ui/build.sh
consul-ui/push.sh &
consul-agent/build.sh
consul-agent/push.sh &
rethinkdb/build.sh
rethinkdb/push.sh &
blue-volume/build.sh
blue-volume/push.sh &

echo "Waiting for pushes to complete..."
wait
echo "Push complete!!"