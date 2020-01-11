#!/usr/bin/env bash

if [ -z "$*" ]; then
 echo "put argument with FILE_NAME m:mutation/q:query/s:subcription format"
 exit 0

fi

FILE_NAME=`echo $1 | cut -d '/' -f2`
ROOT_FOLDER=`echo $1 | cut -d '/' -f1`


if [ "$2" == "s" ]; then
	echo `echo "type Subscription {
		${FILE_NAME}:${ROOT_FOLDER}
	}" > src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.graphql`
	echo "src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.graphql successfully created"
	exit 2
fi

if [ "$2" == "m" ]; then TYPE="Mutation"
elif [ "$2" == "q" ]; then TYPE="Query"
else
	echo "put valid type m/q/s"
	exit 1
fi

echo `echo "type ${FILE_NAME}Response {
	res: Boolean!
	error: String
}

type ${TYPE} {
	${FILE_NAME}:${FILE_NAME}Response!
}" > src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.graphql`
echo "src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.graphql successfully created"
