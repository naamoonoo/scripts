#!/usr/bin/env bash

FILE_NAMES=`echo "ls src/api/**/*.resolvers.ts | cut -d'/' -f3 -f4"`
ROOT_FOLDERS=`echo "ls src/api/**/*.resolvers.ts | cut -d'/' -f3"`

for folder in ${ROOT_FOLDERS}
do
	echo folder
done
