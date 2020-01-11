#!/usr/bin/env bash

if [ -z "$*" ]; then
 echo "put argument with RouterName c:container format"
 exit 0

fi

FILE_NAME=$1
HAS_CONTAINER=$2

echo `mkdir src/Routes/${FILE_NAME}`

echo `echo "import ${FILE_NAME}Presenter from './${FILE_NAME}Presenter'

export default ${FILE_NAME}Presenter" > src/Routes/${FILE_NAME}/index.ts`

echo `echo "import React from 'react';
import { RouteComponentProps } from 'react-router-dom';
import * as S from './${FILE_NAME}Style';

interface IProps extends RouteComponentProps {}

const ${FILE_NAME}Presenter: React.FC<IProps> = () => {
	return <div>${FILE_NAME}Presenter</div>;
};

${FILE_NAME}Presenter.propTypes = {};

export default ${FILE_NAME}Presenter;
" > src/Routes/${FILE_NAME}/${FILE_NAME}Presenter.tsx`

echo `echo "import import styled from 'styled-components';
" > src/Routes/${FILE_NAME}/${FILE_NAME}Style.ts`
if [ "$2" == "c" ]; then


	echo `echo "import React from 'react';
	import { useQuery } from '@apollo/react-hooks';
	import ${FILE_NAME}Presenter from './${FILE_NAME}Presenter';
	import { ThemeProvider } from 'styled-components';
	import { theme } from '../../theme';

	const ${FILE_NAME}Container: React.FC = () => {
		const { loading, error, data } = useQuery(QUERY);

		if (loading) return <p>Loading...</p>;
		if (error) return <p>Error :(</p>;

		console.log(data);

		return (
			<ThemeProvider theme={theme}>
				<${FILE_NAME}Presenter />
			</ThemeProvider>
		);
	};

	export default ${FILE_NAME}Container;
	" > src/Routes/${FILE_NAME}/${FILE_NAME}Container.tsx`

	echo `echo "import { gql } from 'apollo-boost'

	" > src/Routes/${FILE_NAME}/${FILE_NAME}Queries.tsx`

	echo `echo "import ${FILE_NAME}Container from './${FILE_NAME}Container'

	export default ${FILE_NAME}Container" > src/Routes/${FILE_NAME}/index.ts`
fi

