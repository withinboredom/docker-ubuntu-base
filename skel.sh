#!/bin/bash

echo "What would you like to call this container:"
read name

echo "Creating service $name"

mkdir $name
cd $name
mkdir root
mkdir root/etc
mkdir root/etc/consul.d
mkdir root/etc/consul.d/bootstrap
touch root/etc/consul.d/bootstrap/${name}.json

mkdir root/etc/s6
mkdir root/etc/s6/$name
touch root/etc/s6/$name/finish
chmod +x root/etc/s6/$name/finish
touch root/etc/s6/$name/run
chmod +x root/etc/s6/$name/run

touch build.sh
echo "docker build -t withinboredom/$name $name" >> build.sh
chmod +x build.sh

touch Dockerfile
touch README.md

touch push.sh
echo "docker push withinboredom/$name" >> push.sh
chmod +x push.sh