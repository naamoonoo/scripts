#!/usr/bin/env bash

if [ -z "$*" ]; then
 echo "put argument number of day with 3 length format"
 exit 0

fi

echo `ls ~/Downloads/FireShot | cut -d"soultion_"`
# DATE=`date +"_%b_%d"`
# echo `mkdir src/DailyCoding/$1${DATE}`
# echo `mv ~/Downloads/FireShot/*$1* ./src/DailyCoding/$1${DATE}/$1.pdf`
# echo `open ./src/DailyCoding/$1${DATE}/$1.pdf`
# echo `touch ./src/DailyCoding/$1${DATE}/question.md`
# echo `touch ./src/DailyCoding/$1${DATE}/solution.py`
# echo `touch ./src/DailyCoding/$1${DATE}/test_solution.py`
