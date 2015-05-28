#!/bin/bash

ubuntu-base/push.sh &
consul-agent/push.sh &
consul/push.sh &
consul-ui/push.sh &

#echo "Waiting for base push"
#wait

rethinkdb/push.sh &
blue-volume/push.sh &

echo "Waiting for pushes"
wait
echo "All images pushed to repository!"