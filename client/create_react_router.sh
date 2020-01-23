#!/usr/bin/env bash

if [ -z "$*" ]; then
 echo "put argument with r:Routes/c:Components FolderName/ComponentName c:[if it has container] format"
 exit 0

fi


if [ "$1" == "c" ]; then
	FOLDER="Components"
elif [ "$1" == "r" ]; then
	FOLDER="Routes"
else
	echo "put argument with r:Routes/c:Components FolderName/ComponentName c:container format"
	exit1
fi

FILE_NAME=$2

echo `mkdir src/${FOLDER}/${FILE_NAME}`

echo `echo "import ${FILE_NAME}Presenter from './${FILE_NAME}Presenter'

export default ${FILE_NAME}Presenter" > src/${FOLDER}/${FILE_NAME}/index.ts`

echo `echo "import React from 'react';
import * as S from './${FILE_NAME}Style';

interface IProps{}

const ${FILE_NAME}Presenter: React.FC<IProps> = () => {
	return <div>${FILE_NAME}Presenter</div>;
};

export default ${FILE_NAME}Presenter;
" > src/${FOLDER}/${FILE_NAME}/${FILE_NAME}Presenter.tsx`

echo `echo "import styled from 'styled-components';
" > src/${FOLDER}/${FILE_NAME}/${FILE_NAME}Style.ts`

if [ "$3" == "c" ]; then


	echo `echo "import React from 'react';
	import ${FILE_NAME}Presenter from './${FILE_NAME}Presenter';

	const ${FILE_NAME}Container: React.FC = () => {

		return (
				<${FILE_NAME}Presenter />
		);
	};

	export default ${FILE_NAME}Container;
	" > src/${FOLDER}/${FILE_NAME}/${FILE_NAME}Container.tsx`

	echo `echo "import { gql } from 'apollo-boost'

	" > src/${FOLDER}/${FILE_NAME}/${FILE_NAME}Queries.ts`

	echo `echo "import ${FILE_NAME}Container from './${FILE_NAME}Container'

	export default ${FILE_NAME}Container" > src/${FOLDER}/${FILE_NAME}/index.ts`

elif [ "$2" == "d" ]; then
	echo `echo "import React from 'react';

	const ${FILE_NAME}Presenter: React.FC = () => {
		return <div>${FILE_NAME}Presenter</div>;
	};

	export default ${FILE_NAME}Presenter;
	" > src/${FOLDER}/${FILE_NAME}/${FILE_NAME}Presenter.tsx`

	echo `rm src/${FOLDER}/${FILE_NAME}/${FILE_NAME}Style.ts`
fi

