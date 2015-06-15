#!/bin/bash
docker tag -f withinboredom/ubuntu-base withinboredom/nodejs:base
docker build -t withinboredom/nodejs:latest nodejs