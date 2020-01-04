#!/usr/bin/env bash

if [ -z "$*" ] 

 then
 echo "put argument with 'ROOT_FOLDER/FILE_NAME' format"
 exit 0

fi

FILE_NAME=`echo $1 | cut -d '/' -f2`
ROOT_FOLDER=`echo $1 | cut -d '/' -f1`

echo `mkdir src/api/${ROOT_FOLDER}`
echo `mkdir src/api/${ROOT_FOLDER}/${FILE_NAME}`
echo `touch src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.graphql`
echo `touch src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.resolvers.ts`


