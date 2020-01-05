#!/usr/bin/env bash

if [ -z "$*" ]; then
 echo "put argument with FILE_NAME m:mutation/q:query format"
 exit 0

fi

FILE_NAME=`echo $1 | cut -d '/' -f2`
ROOT_FOLDER=`echo $1 | cut -d '/' -f1`

if [ "$2" == "m" ]; then
	TYPE="Mutation"
	ARGS="args"
elif [ "$2" == "q" ]; then
	TYPE="Query"
	ARGS="__"
else
	echo "put valid type m or q"
	exit 1
fi

echo `echo "import { Resolvers } from "../../../types/resolvers";

const resolvers: Resolvers = {
	${TYPE}: {
		${FILE_NAME}: async (_, ${ARGS}, { req }) => {
			return {
				res: true,
				error: null
			};
		}
	}
};

export default resolvers;" > src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.resolvers.ts`
echo "src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.resolvers.ts successfully created"
