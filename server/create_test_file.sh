#!/usr/bin/env bash

if [ -z "$*" ]; then
 echo "put argument with FILE_NAME m:mutation/q:query/s:subcription a:authenticated format"
 exit 0

fi

FILE_NAME=`echo $1 | cut -d '/' -f2`
ROOT_FOLDER=`echo $1 | cut -d '/' -f1`


if [ "$2" == "m" ]; then
	TYPE="mutation"
elif [ "$2" == "q" ]; then
	TYPE="query"
elif [ "$2" == "s" ]; then
	TYPE="subscription"
else
	echo "put valid type m/q/s"
	exit 1
fi

if [ "$3" == "a" ]; then
	echo `echo "
	import { JWT } from '../../../constants';
	import { User } from '../../../entities/User';
	import { ${ROOT_FOLDER} } from '../../../entities/${ROOT_FOLDER}';
	import { getApi } from '../../../testUtils/api';
	import '../../../testUtils/database';
	import { getQuery } from '../../../testUtils/getQuery';
	import { createJWT } from '../../../utils/jwt';

	describe('[${ROOT_FOLDER}]${FILE_NAME}', () => {
		let api;
		let token;

		beforeAll(async () => {
			const user = await User.create({
				firstName: 'test',
				lastName: 'jest',
				email: 'test@test.com',
				password: 'test'
			}).save();
			token = createJWT(user.id);
		});

		beforeEach(() => {
			api = getApi().set(JWT, token);
		});

		const query = ${TYPE} {
				${FILE_NAME}{
					res
					error
				}
			}

		it('expect to pass', async () => {
			const variables = {};
			const response = await api
				.send({ query: getQuery(query, variables) })
				.expect(200)
				.then(response => response.body.data.${FILE_NAME});
			const {res, error } = response;
			expect(res).toBeTruthy();
			expect(error).toBeNull();
			const result = await ${ROOT_FOLDER}.findOne({ ...variables });
			expect(result).not.toBeUndefined();
			expect(result).toMatchObject(variables);
		});

		it('expect to fail', async () => {
			const variables = {};
			const response = await api
				.send({ query: getQuery(query, variables) })
				.expect(200)
				.then(response => response.body.data.${FILE_NAME});
			const {res, error } = response;
			expect(res).toBeFalsy();
			expect(error).toBe('');
			const result = await ${ROOT_FOLDER}.findOne({ ...variables });
			expect(result).toBeUndefined();
		});
	});
" > src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.test.ts`
else
	echo `echo "
	import { ${ROOT_FOLDER} } from '../../../entities/${ROOT_FOLDER}';
	import { getApi } from '../../../testUtils/api';
	import '../../../testUtils/database';
	import { getQuery } from '../../../testUtils/getQuery';

	describe('[${ROOT_FOLDER}]${FILE_NAME}', () => {
		let api;

		beforeEach(() => {
			api = getApi();
		});

		const query = ${TYPE} {
				${FILE_NAME}(
				) {
					res
					error
				}
			}

		it('expect to pass', async () => {
			const variables = {};
			const response = await api
				.send({ query: getQuery(query, variables) })
				.expect(200)
				.then(response => response.body.data.${FILE_NAME});
			const {res, error } = response;
			expect(res).toBeTruthy();
			expect(error).toBeNull();
			const result = await ${ROOT_FOLDER}.findOne({ ...variables });
			expect(result).not.toBeUndefined();
			expect(result).toMatchObject(variables);
		});

		it('expect to fail', async () => {
			const variables = {};
			const response = await api
				.send({ query: getQuery(query, variables) })
				.expect(200)
				.then(response => response.body.data.${FILE_NAME});
			const {res, error } = response;
			expect(res).toBeFalsy();
			expect(error).toBe('');
			const result = await ${ROOT_FOLDER}.findOne({ ...variables });
			expect(result).toBeUndefined();
		});
	});
	" > src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.test.ts`
fi
echo "src/api/${ROOT_FOLDER}/${FILE_NAME}/${FILE_NAME}.test.ts successfully created"
