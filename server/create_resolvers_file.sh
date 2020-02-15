#!/usr/bin/env bash

if [ -z "$*" ]; then
 echo "put argument with FILE_NAME m:mutation/q:query/s:subcription format"
 exit 0

fi

FILE_NAME=`echo $1 | cut -d '/' -f2`
ROOT_FOLDER=`echo $1 | cut -d '/' -f1`


if [ "$2" == "s" ]; then
	echo `echo "import { withFilter } from 'apollo-server-express';

	const resolvers = {
		Subscription: {
			${FILE_NAME}: {
				resolve: payload => payload,
				subscribe: withFilter(
					(_, __, { pubSub }) => {
						return pubSub.asyncIterator();
					},
					(payload, _, { context }) => {
						return true
					}
				)
			}
		}
	};

	export default resolvers;" > src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.resolvers.ts`
	echo "src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.test.ts successfully created"
	exit 2
fi


if [ "$2" == "m" ]; then
	TYPE="Mutation"
	ARGS="args : ${FILE_NAME}${TYPE}Args"
	TYPES="${FILE_NAME}${TYPE}Args, ${FILE_NAME}Response"
elif [ "$2" == "q" ]; then
	TYPE="Query"
	ARGS="__"
	TYPES="${FILE_NAME}Response"
else
	echo "put valid type m/q/s"
	exit 1
fi

if [ "$3" == "a" ]; then
	echo `echo "
	import { ${ROOT_FOLDER} } from '../../../entities/${ROOT_FOLDER}';
	import { User } from '../../../entities/User';
	import { ${TYPES} } from '../../../types/graph';
	import { Resolvers } from '../../../types/resolvers';
	import { authProtector } from '../../../utils/authProtector';

	const resolvers: Resolvers = {
		${TYPE}: {
			${FILE_NAME}: authProtector(
				async (
					_, ${ARGS}, { req }
				): Promise<${FILE_NAME}Response> => {
					const user: User = req.user;
					try {
						return {
							res: true,
							error: null
						}
					} catch (error) {
						return {
							res: false,
							error: error.message,
						};
					}
				}
			)
		}
	};

	export default resolvers;" > src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.resolvers.ts`
else
	echo `echo "
	import { ${ROOT_FOLDER} } from '../../../entities/${ROOT_FOLDER}';
	import { ${TYPES} } from '../../../types/graph';
	import { Resolvers } from '../../../types/resolvers';

	const resolvers: Resolvers = {
		${TYPE}: {
			${FILE_NAME}: async ( _, ${ARGS}, { req }
			): Promise<${FILE_NAME}Response> => {
				try {
					return {
						res: true,
						error: null
					}
				} catch (error) {
					return {
						res: false,
						error: error.message,
					};
				}
			}
		}
	};

export default resolvers;" > src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.resolvers.ts`
fi
echo "src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.resolvers.ts successfully created"
