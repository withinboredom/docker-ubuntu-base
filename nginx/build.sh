#!/bin/bash
docker tag -f withinboredom/consul-agent withinboredom/nginx:base
docker build -t withinboredom/nginx:latest nginx
