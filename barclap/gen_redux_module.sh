#!/usr/bin/env bash
ERROR="put argument [module_name] [A/a: Async or L/l: Local] "

if [ -z "$*" ]; then
 echo ${ERROR}
 exit 0
fi

FILE_NAME=$1
FIRST_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${FILE_NAME:0:1})${FILE_NAME:1}"
CAP="$(tr '[:lower:]' '[:upper:]' <<< ${FILE_NAME:0})"



if [ "$2" == "A" ] || [ "$2" == "a" ]; then
	echo `sh ./gen_redux_module_async.sh $1`
elif [ "$2" == "L" ] || [ "$2" == "l" ]; then
	echo `sh ./gen_redux_module_local.sh $1`
else
	echo ${ERROR}
	exit 1
fi
