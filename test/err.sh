#!/bin/bash

echo "output"
$1 2>out | cat

echo
echo "err"
cat out