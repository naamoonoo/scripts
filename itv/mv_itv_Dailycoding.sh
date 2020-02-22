#!/usr/bin/env bash

if [ -z "$*" ]; then
 echo "put argument number of day with 3 length format"
 exit 0

fi

echo `mkdir src/DailyCoding/$1`
echo `mv ~/Downloads/FireShot/FireShot\ Capture\ $1* ./src/DailyCoding/$1/$1.pdf`
echo `open ./src/DailyCoding/$1/$1.pdf`
