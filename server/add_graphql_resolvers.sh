#!/usr/bin/env bash

if [ -z "$*" ]

 then
 echo "put argument with 'ROOT_FOLDER/FILE_NAME m:mutation/q:query' format"
 exit 0

fi

FILE_NAME=`echo $1 | cut -d '/' -f2`
ROOT_FOLDER=`echo $1 | cut -d '/' -f1`

echo `mkdir src/api/${ROOT_FOLDER}`
echo `mkdir src/api/${ROOT_FOLDER}/${FILE_NAME}`
echo `sh ~/Projects/scripts/server/create_graphql_file.sh $1 $2`
echo `sh ~/Projects/scripts/server/create_resolvers_file.sh $1 $2`


